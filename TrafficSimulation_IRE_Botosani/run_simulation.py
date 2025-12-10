import sys
import os


SUMO_TOOLS = r"C:\Program Files (x86)\Eclipse\Sumo\tools"
if SUMO_TOOLS not in sys.path:
    sys.path.append(SUMO_TOOLS)

import traci
SUMO_BINARY = "sumo-gui"
CONFIG_FILE = "mysim.sumocfg"
SIM_DURATION = 3600
TL_ID = "TL_WEST"

# --- Control Parameters ---
MIN_GREEN_TIME = 15     # Minimum time for vehicle phases
MIN_PED_GREEN_TIME = 10 # Minimum time for pedestrian phase
SWITCH_TIME = 3         # Duration of red clearance phase

# --- Lane Definitions ---
# P0: WEST EAST
TLWest_Phase0_Upstream = [
    "W_P0_UPSTREAM_1", "W_P0_UPSTREAM_2", "W_P0_UPSTREAM_3", 
    "W_P0P1_Upstream_E_P0P2_Downstream_1", "W_P0P1_Upstream_E_P0P2_Downstream_2", "W_P0P1_Upstream_E_P0P2_Downstream_3"
]
TLWest_Phase0_Downstream = [
    "W_P0P2_Downstream_E_P0P1_Upstream_1", "W_P0P2_Downstream_E_P0P1_Upstream_2", "W_P0P2_Downstream_E_P0P1_Upstream_3",
    "W_P0P1P2_Downstream_1", "W_P0P1P2_Downstream_2"
]

# P1: EAST -> West and East -> South
TLWest_Phase1_Upstream = [
    "W_P0P1_Upstream_E_P0P2_Downstream_1",
    "W_P0P1_Upstream_E_P0P2_Downstream_2",
    "W_P0P1_Upstream_E_P0P2_Downstream_3"
]
TLWest_Phase1_Downstream = [
    "W_P0P1P2_Downstream_1", "W_P0P2_Downstream_E_P0P1_Upstream_3"
]

# P2: SOUTH ->  LEFT LEFT RIGHT RIGHT
TLWest_Phase2_Upstream = [
    "S_P2_UPSTREAM_1",
    "S_P2_UPSTREAM_2",
    "S_P2_UPSTREAM_3",
    "S_P2_UPSTREAM_4"
]
TLWest_Phase2_Downstream = [
    "W_P0P2_Downstream_E_P0P1_Upstream_1",
    "W_P0P2_Downstream_E_P0P1_Upstream_2",
    "W_P0P2_Downstream_E_P0P1_Upstream_3",
    "W_P0P1P2_Downstream_1",
    "W_P0P1P2_Downstream_2"
]

# P3: Pedestrian Crossing Detectors
PEDESTRIAN_CROSSINGS = [":TL_WEST_c0_0", ":TL_WEST_c1_0"]


# --- Phase Definitions for TL_WEST (14 signals) ---

PHASE_0_GREEN =       "GGrrrrrrGGGGrr"
PHASE_1_GREEN =       "GGGrrrrrGrrrrr"
PHASE_2_GREEN =       "rrrGGGGGrrrrrr"
PHASE_3_GREEN =       "rrrrrrrrrrrrGG" # Pedestrians

# SAFETY STATE: All Red for transitions
ALL_RED_STATE =       "rrrrrrrrrrrrrr"

# Mapping to calculate vehicle pressure
PHASE_LANE_MAP = {
    "P0": (TLWest_Phase0_Upstream, TLWest_Phase0_Downstream),
    "P1": (TLWest_Phase1_Upstream, TLWest_Phase1_Downstream),
    "P2": (TLWest_Phase2_Upstream, TLWest_Phase2_Downstream),
}

# Mapping for state transitions
PHASE_STATE_MAP = {
    "P0": PHASE_0_GREEN,    "P1": PHASE_1_GREEN,
    "P2": PHASE_2_GREEN,    "P3": PHASE_3_GREEN
}

# Cycle order for Max Pressure check
CYCLE = ["P0", "P1", "P2", "P3"]
PHASES_PER_CYCLE = len(CYCLE)


# --- Max Pressure Logic ---
class MaxPressureController:
    def __init__(self, tls_id):
        self.id = tls_id
        self.current_phase_key = "P0"
        self.timer = 0
        self.is_switching = False
        
        traci.trafficlight.setRedYellowGreenState(self.id, PHASE_STATE_MAP["P0"])
        traci.trafficlight.setProgram(self.id, "off") 

    def get_pressure_for_phase(self, phase_key):
        """Calculates Max Pressure (Upstream Halting - Downstream Halting) for a phase."""
        if phase_key == "P3":
            # P3 (Pedestrian) pressure is based on waiting pedestrians
            waiting_pedestrians = 0
            for crossing in PEDESTRIAN_CROSSINGS:
                try:
                    waiting_pedestrians += traci.lane.getLastStepVehicleNumber(crossing)
                except:
                    pass
            return waiting_pedestrians * 10 
        
        upstream_lanes, downstream_lanes = PHASE_LANE_MAP[phase_key]
        
        def get_halting_count(lane_list):
            count = 0
            for lane in lane_list:
                try:
                    count += traci.lane.getLastStepHaltingNumber(lane)
                except:
                    pass
            return count

        occ_up = get_halting_count(upstream_lanes)
        occ_down = get_halting_count(downstream_lanes)
        
        return occ_up - occ_down

    def get_max_pressure_phase(self):
        """Returns the phase key (P0-P3) with the highest pressure."""
        pressures = {}
        for phase in CYCLE:
            pressures[phase] = self.get_pressure_for_phase(phase)
        
        max_pressure = -float('inf')
        max_phase = self.current_phase_key 

        for phase, pressure in pressures.items():
            if pressure > max_pressure:
                max_pressure = pressure
                max_phase = phase
                
        return max_phase, max_pressure

    def update(self):
        self.timer += 1
        
        # --- 1. Handle All-Red Switching Logic ---
        if self.is_switching:
            if self.timer >= SWITCH_TIME:
                self.timer = 0
                self.is_switching = False
                
                # Parse target index from 'yXtoY'
                try:
                    target_idx = int(self.current_phase_key.split('to')[1])
                    next_green_key = CYCLE[target_idx]
                except:
                    # Fallback logic
                    current_idx = int(self.current_phase_key[1]) 
                    next_green_key = CYCLE[(current_idx + 1) % PHASES_PER_CYCLE]

                self.current_phase_key = next_green_key

                traci.trafficlight.setRedYellowGreenState(
                    self.id, PHASE_STATE_MAP[self.current_phase_key]
                )
            return

        # --- 2. Check for Phase Switch ---
        min_duration = MIN_PED_GREEN_TIME if self.current_phase_key == "P3" else MIN_GREEN_TIME
        
        if self.timer >= min_duration:
            
            next_max_phase, next_max_pressure = self.get_max_pressure_phase()
            current_pressure = self.get_pressure_for_phase(self.current_phase_key)
            
            # Switch if another phase has higher pressure
            if next_max_phase != self.current_phase_key and next_max_pressure > current_pressure:
                
                self.is_switching = True
                self.timer = 0
                
                current_idx = CYCLE.index(self.current_phase_key)
                target_idx = CYCLE.index(next_max_phase) 
                
                yellow_key = f"y{current_idx}to{target_idx}"
                self.current_phase_key = yellow_key
                
                # We don't overcomplicate with yellow state, all red will suffice
                traci.trafficlight.setRedYellowGreenState(self.id, ALL_RED_STATE)


# --- Main Simulation Loop ---
def main():
    sumo_cmd = [SUMO_BINARY, "-c", CONFIG_FILE]
    
    try:
        traci.start(sumo_cmd)
    except traci.exceptions.FatalTraCIError as e:
        print(f"FATAL ERROR: Could not start SUMO or connect via TraCI. Details: {e}")
        sys.exit(1)

    try:
        controller = MaxPressureController(TL_ID)
    except traci.exceptions.TraCIException:
        print(f"Error: Traffic light ID '{TL_ID}' not found or connection issue. Exiting.")
        traci.close()
        sys.exit(1)


    step = 0
    print(f"Running simulation for {SIM_DURATION} steps...")
    while step < SIM_DURATION:
        traci.simulationStep()
        controller.update()
        step += 1

    traci.close()
    print("Simulation successfully ended.")


if __name__ == "__main__":
    main()