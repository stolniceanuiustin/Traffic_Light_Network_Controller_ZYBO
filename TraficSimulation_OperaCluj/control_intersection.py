import sys
import os

# --- Configuration ---
# Update this path if necessary based on your SUMO installation
SUMO_TOOLS = r"C:\Program Files (x86)\Eclipse\Sumo\tools"
if SUMO_TOOLS not in sys.path:
    sys.path.append(SUMO_TOOLS)

import traci

SUMO_BINARY = "sumo-gui"  # Use "sumo" for no GUI
CONFIG_FILE = "mysim.sumocfg"

# Time in seconds
MIN_GREEN_TIME = 10
SWITCH_TIME = 3
SIM_DURATION = 3600

# --- Traffic Light Definitions ---
# Each key is the TL ID from the .net.xml file.
# The dictionary contains the phase strings and the specific lane IDs.

TRAFFIC_LIGHTS = {
    "TL0": {
        "phases": {
            "green_1": "GGGrrr",
            "green_2": "rrrGGG",
            "yellow_1to2": "yyyrrr",
            "yellow_2to1": "rrryyy"
        },
        "lanes": {
            "p1_upstream": ["TL0_P1_Upstream_0", "TL0_P1_Upstream_1", "TL0_P1_Upstream_2"],
            "p2_upstream": ["TL0_P2_Upstream_TL8_P1P2_Downstream_0", "TL0_P2_Upstream_TL8_P1P2_Downstream_1",
                            "TL0_P2_Upstream_TL8_P1P2_Downstream_2"],
            "downstream": ["TL0_Downstream_0", "TL0_Downstream_1", "TL0_Downstream_2"]
        }
    },
    "TL1": {
        "phases": {
            "green_1": "GGGGGrrrrr",
            "green_2": "rrrrrGGGGG",
            "yellow_1to2": "yyyyyrrrrr",
            "yellow_2to1": "rrrrryyyyy"
        },
        "lanes": {
            # Phase 1: Edge TL1_P2_Upstream (Indices 0-4 in connection logic)
            "p1_upstream": ["TL1_P2_Upstream_0", "TL1_P2_Upstream_1", "TL1_P2_Upstream_2"],
            # Phase 2: Edge TL1_P1_Upstream (Indices 5-9 in connection logic)
            "p2_upstream": ["TL1_P1_Upstream_0", "TL1_P1_Upstream_1"],
            "downstream": ["TL2_P1_Upstream_0", "TL2_P1_Upstream_1", "TL2_P1_Upstream_2", "TL2_P1_Upstream_3",
                           "TL2_P1_Upstream_4"]
        }
    },
    "TL2": {
        "phases": {
            "green_1": "GGGGGrrrrrrr",
            "green_2": "rrrrrGGGGGGG",
            "yellow_1to2": "yyyyyrrrrrrr",
            "yellow_2to1": "rrrrryyyyyyy"
        },
        "lanes": {
            "p1_upstream": ["TL2_P2_Upstream_0", "TL2_P2_Upstream_1"],
            "p2_upstream": ["TL2_P1_Upstream_0", "TL2_P1_Upstream_1", "TL2_P1_Upstream_2", "TL2_P1_Upstream_3",
                            "TL2_P1_Upstream_4"],
            # Exits to TL7 upstream and TL3 upstream
            "downstream": ["TL2_P0P1_Downstream_TL7_P1_Upstream_0", "TL2_P0P1_Downstream_TL7_P1_Upstream_1",
                           "TL2_P0P1_Downstream_TL7_P1_Upstream_2", "TL3_P1_Upstream_0", "TL3_P1_Upstream_1"]
        }
    },
    "TL3": {
        "phases": {
            "green_1": "GgggGGGGrrrrrr",
            "green_2": "rrrrrrrrGGGGGG",
            "yellow_1to2": "yyyyyyyyrrrrrr",
            "yellow_2to1": "rrrrrrrryyyyyy"
        },
        "lanes": {
            "p1_upstream": ["TL3_P1_Upstream_0", "TL3_P1_Upstream_1", "TL3_P1_Upstream_2", "TL3_P1_Upstream_3",
                            "TL3_P1_Upstream_4"],
            "p2_upstream": ["TL6_P1P2_Downstream_TL3_P2_Upstream_0", "TL6_P1P2_Downstream_TL3_P2_Upstream_1",
                            "TL6_P1P2_Downstream_TL3_P2_Upstream_2", "TL6_P1P2_Downstream_TL3_P2_Upstream_3",
                            "TL6_P1P2_Downstream_TL3_P2_Upstream_4"],
            "downstream": ["TL3_P1P2_Downstream_Doro_0", "TL3_P1P2_Downstream_Doro_1",
                           "TL3_P1P2_DownstreamC_TL4_P1_Upstream_0", "TL3_P1P2_DownstreamC_TL4_P1_Upstream_1"]
        }
    },
    "TL4": {
        # Note: TL4 has a complex phase definition in xml.
        # Simplified here to two main opposing movements for MaxPressure.
        "phases": {
            "green_1": "GGGGGGGGrrrrrrrrrG",
            "green_2": "rrrrrrrrgGGGGGGGGr",
            "yellow_1to2": "yyyyyyyyrrrrrrrrry",
            "yellow_2to1": "rrrrrrrryyyyyyyyyr"
        },
        "lanes": {
            "p1_upstream": ["TL4_P1_Upstream_0", "TL4_P1_Upstream_1", "TL4_P1_Upstream_2", "TL4_P1_Upstream_3",
                            "TL4_P1_Upstream_4"],
            "p2_upstream": ["TL3_P1P2_DownstreamC_TL4_P1_Upstream_0", "TL3_P1P2_DownstreamC_TL4_P1_Upstream_1",
                            "TL3_P1P2_DownstreamC_TL4_P1_Upstream_2", "TL3_P1P2_DownstreamC_TL4_P1_Upstream_3",
                            "TL3_P1P2_DownstreamC_TL4_P1_Upstream_4"],
            "downstream": ["TL4_P1P2_Downstream_TL5_P1_Upstream_0", "TL4_P1P2_Downstream_TL5_P1_Upstream_1",
                           "TL4_P0_Upstream_0"]
        }
    },
    "TL5": {
        "phases": {
            "green_1": "GGGGGggGGggrrrrrrr",
            "green_2": "GrrrrrrrrrrGGGGGGG",
            "yellow_1to2": "yyyyyggyyggrrrrrrr",
            "yellow_2to1": "Grrrrrrrrrryyyyyyy"
        },
        "lanes": {
            "p1_upstream": ["TL4_P1P2_Downstream_TL5_P1_Upstream_0", "TL4_P1P2_Downstream_TL5_P1_Upstream_1",
                            "TL4_P1P2_Downstream_TL5_P1_Upstream_2", "TL4_P1P2_Downstream_TL5_P1_Upstream_3",
                            "TL4_P1P2_Downstream_TL5_P1_Upstream_4", "TL4_P1P2_Downstream_TL5_P1_Upstream_5",
                            "TL4_P1P2_Downstream_TL5_P1_Upstream_6"],
            "p2_upstream": ["TL5_P2_Upstream_0", "TL5_P2_Upstream_1", "TL5_P2_Upstream_2"],
            "downstream": ["TL5_P1P2_Downstream_TL6_P1_Upstream_0", "TL5_P1P2_Downstream_TL6_P1_Upstream_1",
                           "TL5_P1_Upstream_0", "TL5_P0_Bus_Downstream_0"]
        }
    },
    "TL6": {
        "phases": {
            "green_1": "GGGGGGGrrrrrrrrr",
            "green_2": "rrrrrrrGGGGGGGGG",
            "yellow_1to2": "yyyyyyyrrrrrrrrr",
            "yellow_2to1": "rrrrrrryyyyyyyyy"
        },
        "lanes": {
            "p1_upstream": ["TL6_P2_UPSTREAM_0", "TL6_P2_UPSTREAM_1", "TL6_P2_UPSTREAM_2", "TL6_P2_UPSTREAM_3"],
            "p2_upstream": ["TL5_P1P2_Downstream_TL6_P1_Upstream_0", "TL5_P1P2_Downstream_TL6_P1_Upstream_1",
                            "TL5_P1P2_Downstream_TL6_P1_Upstream_2", "TL5_P1P2_Downstream_TL6_P1_Upstream_3"],
            "downstream": ["TL6_P1P2_Downstream_TL3_P2_Upstream_0", "TL6_P1P2_Downstream_TL3_P2_Upstream_1",
                           "TL6_P1P2_Downstream_TL3_P2_Upstream_2", "TL6_P1P2_Downstream_TL3_P2_Upstream_3"]
        }
    },
    "TL7": {
        "phases": {
            "green_1": "GGGGGrrrrr",
            "green_2": "rrrrrGGGGG",
            "yellow_1to2": "yyyyyrrrrr",
            "yellow_2to1": "rrrrryyyyy"
        },
        "lanes": {
            "p1_upstream": ["TL2_P0P1_Downstream_TL7_P1_Upstream_0", "TL2_P0P1_Downstream_TL7_P1_Upstream_1",
                            "TL2_P0P1_Downstream_TL7_P1_Upstream_2", "TL2_P0P1_Downstream_TL7_P1_Upstream_3"],
            "p2_upstream": ["TL7_P2_Upstream_0", "TL7_P2_Upstream_1", "TL7_P2_Upstream_2", "TL7_P2_Upstream_3",
                            "TL7_P2_Upstream_4"],
            "downstream": ["TL7_P1P2_Downstream_TL8_P1_Upstream_0", "TL7_P1P2_Downstream_TL8_P1_Upstream_1",
                           "TL7_P1P2_Downstream_TL8_P1_Upstream_2", "TL7_P1P2_Downstream_TL8_P1_Upstream_3"]
        }
    },
    "TL8": {
        "phases": {
            "green_1": "GGGGrrrrr",
            "green_2": "rrrrGGGGG",
            "yellow_1to2": "yyyyrrrrr",
            "yellow_2to1": "rrrryyyyy"
        },
        "lanes": {
            "p1_upstream": ["TL8_P2_Upstream_0", "TL8_P2_Upstream_1", "TL8_P2_Upstream_2"],
            "p2_upstream": ["693785226_0", "693785226_1", "693785226_2", "693785226_3", "693785226_4"],
            "downstream": ["TurziiDeal_0", "TurziiDeal_1", "TL0_P2_Upstream_TL8_P1P2_Downstream_0",
                           "TL0_P2_Upstream_TL8_P1P2_Downstream_1"]
        }
    },
    "TL9": {
        "phases": {
            "green_1": "GGGGrrrrrr",  # Simplified Phase 3 from xml (Major flow)
            "green_2": "rrrrGGGGrr",  # Simplified Phase 5 from xml
            "yellow_1to2": "yyyyrrrrrr",
            "yellow_2to1": "rrrryyyGrr"
        },
        "lanes": {
            "p1_upstream": ["TL9_P2P3_Upstream_0", "TL9_P2P3_Upstream_1", "TL9_P2P3_Upstream_2"],
            "p2_upstream": ["TL9_P4_Upstream_0", "TL9_P4_Upstream_1"],
            "downstream": ["TL9_P1_Downstream1_0", "TL9_P1_Downstream_2_0", "E18_0", "E18_1"]
        }
    },
}


# --- State Management Class ---
class TrafficLightController:
    def __init__(self, tls_id, config):
        self.id = tls_id
        self.config = config
        self.current_phase_key = "green_1"  # Start with phase 1
        self.timer = 0
        self.is_switching = False

        # Set initial state in SUMO
        traci.trafficlight.setRedYellowGreenState(self.id, self.config["phases"][self.current_phase_key])

    def get_pressure(self):
        """Calculates pressure for Phase 1 vs Phase 2"""

        # Occupancy = Number of halting vehicles
        def get_halting(lane_list):
            count = 0
            for lane in lane_list:
                try:
                    count += traci.lane.getLastStepHaltingNumber(lane)
                except:
                    pass
            return count

        occ_p1_up = get_halting(self.config["lanes"]["p1_upstream"])
        occ_p2_up = get_halting(self.config["lanes"]["p2_upstream"])
        occ_down = get_halting(self.config["lanes"]["downstream"])

        # Pressure = Upstream - Downstream
        # We calculate specific pressure for P1 and P2 flows
        pressure_p1 = occ_p1_up - occ_down
        pressure_p2 = occ_p2_up - occ_down

        return pressure_p1, pressure_p2

    def update(self):
        self.timer += 1

        # 1. Handle Yellow Switching Logic
        if self.is_switching:
            if self.timer >= SWITCH_TIME:
                self.timer = 0
                self.is_switching = False

                # Complete the switch to Green
                if self.current_phase_key == "yellow_1to2":
                    self.current_phase_key = "green_2"
                elif self.current_phase_key == "yellow_2to1":
                    self.current_phase_key = "green_1"

                traci.trafficlight.setRedYellowGreenState(self.id, self.config["phases"][self.current_phase_key])
            return

        # 2. Check for Phase Switch (Only if Min Green Time passed)
        if self.timer >= MIN_GREEN_TIME:
            p1_pressure, p2_pressure = self.get_pressure()

            trigger_switch = False

            # If currently Green 1, check if Green 2 needs it more
            if self.current_phase_key == "green_1":
                if p2_pressure > p1_pressure:
                    trigger_switch = True
                    self.current_phase_key = "yellow_1to2"

            # If currently Green 2, check if Green 1 needs it more
            elif self.current_phase_key == "green_2":
                if p1_pressure > p2_pressure:
                    trigger_switch = True
                    self.current_phase_key = "yellow_2to1"

            if trigger_switch:
                self.is_switching = True
                self.timer = 0
                traci.trafficlight.setRedYellowGreenState(self.id, self.config["phases"][self.current_phase_key])
                # print(f"{self.id} switching. P1: {p1_pressure}, P2: {p2_pressure}")


# --- Main Simulation Loop ---
def main():
    traci.start([SUMO_BINARY, "-c", CONFIG_FILE])

    # Initialize controllers for all lights defined in dictionary
    controllers = []
    available_tls = traci.trafficlight.getIDList()

    for tls_id, config in TRAFFIC_LIGHTS.items():
        if tls_id in available_tls:
            controllers.append(TrafficLightController(tls_id, config))
        else:
            print(f"Warning: {tls_id} defined in script but not found in simulation.")

    step = 0
    while step < SIM_DURATION:
        traci.simulationStep()

        # Update every controller
        for controller in controllers:
            controller.update()

        step += 1

    traci.close()
    print("Simulation ended.")


if __name__ == "__main__":
    main()