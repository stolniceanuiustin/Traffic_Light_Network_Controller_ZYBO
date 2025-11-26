import sys
import os

SUMO_TOOLS = r"C:\Program Files (x86)\Eclipse\Sumo\tools"

if SUMO_TOOLS not in sys.path:
    sys.path.append(SUMO_TOOLS)

import traci
SUMO_BINARY = "sumo-gui"
CONFIG_FILE = "mysim.sumocfg"


TL0_PHASE1_GREEN = "GGGrrr"
TL0_PHASE2_GREEN = "rrrGGG"
TL0_PHASE_1TO2_YELLOW = "yyyrrr"
TL0_PHASE_2TO1_YELLOW = "rrryyy"

TL1_PHASE1_GREEN = "GGrrr"
TL1_PHASE2_GREEN = "rrGGG"
TL1_PHASE_1TO2_YELLOW = "yyrrr"
TL1_PHASE_2TO1_YELLOW = "rryyy"

# Allowed state strings for recognition:
GREEN_PHASES = {TL0_PHASE1_GREEN, TL0_PHASE2_GREEN, TL1_PHASE1_GREEN, TL1_PHASE2_GREEN}

MIN_GREEN_TIME = 10
SWITCH_TIME = 1


TL0_PHASE_1_LANES = [
    "TL0_P1_Upstream_0", "TL0_P1_Upstream_1", "TL0_P1_Upstream_2"
]

TL0_PHASE_2_LANES = [
    "TL0_P2_Upstream_TL8_P1P2_Downstream_0",
    "TL0_P2_Upstream_TL8_P1P2_Downstream_1",
    "TL0_P2_Upstream_TL8_P1P2_Downstream_2",
]

TL1_PHASE_1_LANES = [
    "TL1_P1_Upstream_0",
    "TL0_P1_Upstream_1"
    ]

TL2_PHASE_2_LANES = [
    "TL1_P2_Upstream_0",
    "TL1_P2_Upstream_1",
    "TL1_P2_Upstream_2"
]

SIM_DURATION = 3600


# -------------------------------------------------------------
def get_current_pressure(lane_ids):
    """Sum of halting vehicles on given lanes."""
    total = 0
    for lane in lane_ids:
        try:
            total += traci.lane.getLastStepHaltingNumber(lane)
        except traci.TraCIException:
            pass
    return total


# -------------------------------------------------------------
def main():
    traci.start([SUMO_BINARY, "-c", CONFIG_FILE])

    tls_ids = traci.trafficlight.getIDList()
    if not tls_ids:
        print("No traffic lights found.")
        traci.close()
        return

    tls_id = tls_ids[0]
    print(f"Selected TL: {tls_id}")

    # Set default start phase
    current_phase = TL0_PHASE1_GREEN
    traci.trafficlight.setRedYellowGreenState(tls_id, current_phase)

    phase_timer = 0
    is_switching = False

    step = 0
    while step < SIM_DURATION:
        traci.simulationStep()
        phase_timer += 1

        if is_switching:
            if phase_timer >= SWITCH_TIME:
                is_switching = False
                phase_timer = 0

                if current_phase == TL0_PHASE_1TO2_YELLOW:
                    current_phase = TL0_PHASE2_GREEN
                elif current_phase == TL0_PHASE_2TO1_YELLOW:
                    current_phase = TL0_PHASE1_GREEN

                traci.trafficlight.setRedYellowGreenState(tls_id, current_phase)
                print(f"[{step}] Switched to GREEN: {current_phase}")

            step += 1
            continue

        if current_phase not in GREEN_PHASES:
            step += 1
            continue

        pressure_A = get_current_pressure(TL0_PHASE_1_LANES)
        pressure_B = get_current_pressure(TL0_PHASE_2_LANES)
        pressure_diff = pressure_A - pressure_B

        can_switch = phase_timer >= MIN_GREEN_TIME
        trigger_switch = False

        if can_switch:
            if current_phase == TL0_PHASE1_GREEN and pressure_diff < 0:
                trigger_switch = True
            elif current_phase == TL0_PHASE2_GREEN and pressure_diff > 0:
                trigger_switch = True

        if trigger_switch:
            is_switching = True
            phase_timer = 0

            print(f"[{step}] Switching triggered: A={pressure_A}, B={pressure_B}")

            if current_phase == TL0_PHASE1_GREEN:
                current_phase = TL0_PHASE_1TO2_YELLOW
            else:
                current_phase = TL0_PHASE_2TO1_YELLOW

            traci.trafficlight.setRedYellowGreenState(tls_id, current_phase)

        step += 1

    traci.close()
    print("Simulation ended.")


if __name__ == "__main__":
    main()