import sys
import os
import serial
import time
import struct
import binascii
import random 

# ==== SUMO CONFIGURATION ==== #
SUMO_TOOLS = r"C:\Program Files (x86)\Eclipse\Sumo\tools"
if SUMO_TOOLS not in sys.path:
    sys.path.append(SUMO_TOOLS)

import traci

SUMO_BINARY = "sumo-gui"
CONFIG_FILE = "mysim.sumocfg"
SIM_DURATION = 3600
TL_ID = "TL_WEST"
TL_EAST_ID = "TL_EAST"
DEBUG = True
FREQUENCY_CONTROL = False

# ==== SERIAL CONFIGURATION ==== 
SERIAL_PORT = 'COM45' 
BAUD_RATE = 9600

CHUNK_SIZE = 3
# -------------------------------------

START_STOP_DELIMITER = 0xFF 
PADDING_BYTE = 0x00
RECEIVE_TIMEOUT = 5  

# ==== LANE & MAPPING DEFINITIONS ==== 

# Maps Lane IDs(0-16) to SUMO Lane ID Strings
TLWest_Lane_Dictionary = {
    0: "W_P0P1P2_Downstream_1",
    1: "W_P0P1P2_Downstream_2",
    2: "W_P0_UPSTREAM_3",
    3: "W_P0_UPSTREAM_2",
    4: "W_P0_UPSTREAM_1",
    5: "E5_1",  
    6: "E5_2",  
    7: "S_P2_UPSTREAM_4",
    8: "S_P2_UPSTREAM_3",
    9: "S_P2_UPSTREAM_2",
    10: "S_P2_UPSTREAM_1",
    11: "W_P0P2_Downstream_E_P0P1_Upstream_1",
    12: "W_P0P2_Downstream_E_P0P1_Upstream_2",
    13: "W_P0P2_Downstream_E_P0P1_Upstream_3",
    14: "W_P0P1_Upstream_E_P0P2_Downstream_3",
    15: "W_P0P1_Upstream_E_P0P2_Downstream_2",
    16: "W_P0P1_Upstream_E_P0P2_Downstream_1"
}

TLEast_Lane_Dictionary = {
    0: "N_P1_Upstream_1", 
    1: "N_P1_Upstream_2",
    2: "N_P2_Upstream_4",
    3: "N_P2_Upstream_3",
    4: "N_P2_Upstream_2",
    5: "N_P2_Upstream_1",
    6: "W_P0P1_Upstream_E_P0P2_Downstream_1",
    7: "W_P0P1_Upstream_E_P0P2_Downstream_2",
    8: "W_P0P1_Upstream_E_P0P2_Downstream_3",
    9: "W_P0P2_Downstream_E_P0P1_Upstream_3",
    10: "W_P0P2_Downstream_E_P0P1_Upstream_2",
    11: "W_P0P2_Downstream_E_P0P1_Upstream_1",
    12: "E_P0P2_Downstream_1",
    13: "E_P0P2_Downstream_2",
    14: "E_P0_Upstream_2",
    15: "E_P0_Upstream_1"
}

TL_West_Downstream_Lanes = [0,1,5,6,11,12,13]
TL_East_Downstream_Lanes = [12,13,6,7,8,0,1]

# Mapping SUMO Signal Index -> Hardware Lane ID
TL_West_sumo_to_hw_index = [16, 15, 14, 7, 7, 9, 10, 10, 4, 3, 2, 2]
TL_East_sumo_to_hw_index = [2, 3, 4, 5, 5, 14, 14, 15, 15, 11, 10, 9]

# ==== HELPER FUNCTIONS ==== #

def build_transmission_packet(values):
    """Encodes and chunks the traffic values for transmission"""
    encoded_data = [val + 1 for val in values]
    full_message_body = [START_STOP_DELIMITER] + encoded_data + [START_STOP_DELIMITER]

    message_length = len(full_message_body)
    
    # --- CHANGE 2: Dynamic Padding Calculation ---
    # This logic automatically adjusts to CHUNK_SIZE = 7
    # Example: If msg is 19 bytes, 19 % 7 = 5. Needed = 7 - 5 = 2. Total = 21 (3 chunks).
    padding_needed = (CHUNK_SIZE - (message_length % CHUNK_SIZE)) % CHUNK_SIZE
    padded_message = full_message_body + [PADDING_BYTE] * padding_needed
    
    bytes_to_send = bytes(padded_message)
    if(DEBUG):
        print(f" [TX] Original Size: {message_length} bytes. Padded to: {len(bytes_to_send)} (Chunks of {CHUNK_SIZE})")
    return bytes_to_send

def send_data_chunks(ser, bytes_to_send):
    """Sends the prepared byte sequence in CHUNK_SIZE byte chunks."""
    # --- CHANGE 3: Loop Logic uses new CHUNK_SIZE ---
    for i in range(0, len(bytes_to_send), CHUNK_SIZE):
        chunk = bytes_to_send[i:i + CHUNK_SIZE]
        ser.write(chunk)
        # You might be able to reduce this sleep slightly since packets are smaller,
        # but 0.005 is safe. If garbage persists, INCREASE this to 0.010.
        time.sleep(0.005) 

Lane_Cnt_Dict = {
    "TL_West": (17, 2),
    "TL_East": (16, 2)
}

def receive_traffic_state(ser, expected_id):
    """ 
    Reads a length-prefixed packet. Checks ID to prevent crashes.
    Format: [Len][ID][Statuses...][Pot][ID]
    """
    try:
        # 1. Read Length
        length_byte = ser.read(1)
        if not length_byte: return None 
            
        packet_size = int.from_bytes(length_byte, byteorder='big')
        
        # Sanity Check
        if packet_size < 5 or packet_size > 64:
             # print(f" [RX] Warning: Invalid packet size ({packet_size}). Flushing.")
             ser.reset_input_buffer()
             return None

        # 2. Read Payload
        data = ser.read(packet_size)
        
        # Check if we got full data to avoid NameError/IndexError
        if len(data) != packet_size:
            # print(f" [RX] Error: Expected {packet_size} bytes, got {len(data)}")
            return None

        # 3. Validation: Check Start ID against what we expected
        start_id_char = data[0:1].decode('ascii')
        end_id_char = data[packet_size - 1 : packet_size].decode('ascii')

        if start_id_char != expected_id:
            # This is the "Garbage Packet" filter. 
            # If we wanted 'W' but got 'E', return None so we don't crash.
            return None

        # 4. Extract Data
        # Pot Value is at Index N-2
        pot_value = int(data[packet_size - 2])
        
        # Status String is from Index 1 to N-2
        status_string = data[1 : packet_size - 2].decode('ascii')

        # 5. Parse Statuses based on ID
        if start_id_char == 'W':
            car_lane_cnt = Lane_Cnt_Dict["TL_West"][0]
            ped_lane_cnt = Lane_Cnt_Dict["TL_West"][1]
        elif start_id_char == 'E':
            car_lane_cnt = Lane_Cnt_Dict["TL_East"][0]
            ped_lane_cnt = Lane_Cnt_Dict["TL_East"][1]
        
        # Safety Check for string slicing
        if len(status_string) < (car_lane_cnt + ped_lane_cnt):
             return None

        statuses = {
            "Car_Lights": status_string[0 : car_lane_cnt], 
            "Ped_Lights": status_string[car_lane_cnt : car_lane_cnt + ped_lane_cnt], 
            "Pot_Value": pot_value,
            "Raw_String": data.hex() 
        }
        return statuses

    except Exception as e:
        # print(f" [RX] General error: {e}")
        return None

def get_traffic_values(Traffic_Values, Lane_Dictionary):
    """Refreshes the Traffic_Values list with current SUMO data"""
    Traffic_Values.clear() 
    
    for i in range(len(Lane_Dictionary)):
        lane_id = Lane_Dictionary.get(i)
        if lane_id:
            try:
                val_to_send = 0
                if i in TL_West_Downstream_Lanes:
                      occupancy_fraction = traci.lane.getLastStepOccupancy(lane_id)
                      if(occupancy_fraction >= 90):
                        val_to_send = occupancy_fraction / 10
                else:
                    val_to_send = traci.lane.getLastStepVehicleNumber(lane_id)
                if val_to_send > 254: val_to_send = 254
                Traffic_Values.append(int(val_to_send))
            except traci.exceptions.TraCIException:
                Traffic_Values.append(0)
        else:
            Traffic_Values.append(0)

WEST_ROUTES = [
    ["S_P2_UPSTREAM",
     "W_P0P2_Downstream_E_P0P1_Upstream",
     "N_P1_Upstream"],

    ["S_P2_UPSTREAM",
     "W_P0P1P2_Downstream",
     "E1"],

    ["S_P2_UPSTREAM",
     "W_P0P2_Downstream_E_P0P1_Upstream",
     "E_P0P2_Downstream",
     "E6"],

    ["S_P2_UPSTREAM",
     "W_P0P1P2_Downstream",
     "E2"],
]

WEST_LANES = [
    "S_P2_UPSTREAM_1",
    "S_P2_UPSTREAM_2",
    "S_P2_UPSTREAM_3",
    "S_P2_UPSTREAM_4",
]

VEH_TYPE = "car"
vehicle_counter = 0
def generate_cars_west(pot_value):
    global vehicle_counter

    if pot_value <= 0:
        return

    # Map 0-127 to a probability 0.0 - 1.0
    # Example: 2 / 127 = 0.015 (1.5% chance per step)
    spawn_probability = pot_value / 127.0
    
    # Only spawn if the random roll is less than the probability
    if random.random() > spawn_probability:
        return

    # If we pass the check, spawn ONE car
    veh_id = f"west_car_{vehicle_counter}"
    vehicle_counter += 1

    route_edges = WEST_ROUTES[vehicle_counter % len(WEST_ROUTES)]
    route_id = f"route_{veh_id}"

    try:
        traci.route.add(route_id, route_edges)
        traci.vehicle.add(
            vehID=veh_id,
            routeID=route_id,
            typeID=VEH_TYPE,
            departLane="best",
            departSpeed="max"
        )
        if DEBUG:
            print(f"[GEN] Spawned {veh_id} (Pot: {pot_value})")

    except traci.TraCIException as e:
        print(f"[GEN WEST ERROR] {veh_id}: {e}")

#this works only for traffic light west for now
def parse_status_to_sumo_phase(status_dict, sumo_to_hw, ped_lane_cnt):
    """Converts the Hardware Status Dictionary to a SUMO phase string"""
    car_string = status_dict["Car_Lights"]
    peds = status_dict["Ped_Lights"] 
    
    def translate(char):
        if char == 'G': return 'G'
        if char == 'Y': return 'y'
        if char == 'R': return 'r'
        return 'N' # Default/N

    phase_chars = []
    
    for lane_id in sumo_to_hw:
        status = car_string[lane_id]
        phase_chars.append(translate(status))

    for i in range(ped_lane_cnt):
        phase_chars.append(translate(peds[i]))
    return "".join(phase_chars)


# ==== MAIN SIMULATION LOOP ==== 

def main():
    sumo_cmd = [SUMO_BINARY, "-c", CONFIG_FILE]
    
    # Start SUMO
    try:
        traci.start(sumo_cmd)
    except traci.exceptions.FatalTraCIError as e:
        print(f"FATAL ERROR: {e}")
        sys.exit(1)

    # Open Serial
    try:
        ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1.0)
        time.sleep(2) # Wait for Arduino reset
        print("Serial Port Opened. Starting Simulation...")
    except serial.SerialException as e:
        print(f"Error opening serial port: {e}")
        traci.close()
        sys.exit(1)


    TL_WEST_TRAFFIC_VALUES = []
    TL_EAST_TRAFFIC_VALUES = []
    step = 0
    
    print(f"Running simulation for {SIM_DURATION} steps...")
    
    try:
        while step < SIM_DURATION:
            start_time = time.time()
            traci.simulationStep()

            # ================= WEST INTERSECTION =================
            get_traffic_values(TL_WEST_TRAFFIC_VALUES, TLWest_Lane_Dictionary)

            if(DEBUG):
                print(f"\n[Step {step}] TX Traffic Counts WEST (Total {len(TL_WEST_TRAFFIC_VALUES)} lanes):")
                print(f"    Raw Counts: {TL_WEST_TRAFFIC_VALUES}")
            
            # 1. FLUSH BUFFER (Fixes sync issues)
            ser.reset_input_buffer()

            # Send data to Traffic Control Device
            packet = build_transmission_packet(TL_WEST_TRAFFIC_VALUES)
            send_data_chunks(ser, packet)

            # Wait for response (Requesting 'W')
            status_data_west = receive_traffic_state(ser, 'W')

            # Change Phase
            if status_data_west:
                raw_str = status_data_west["Raw_String"]
                cars = status_data_west["Car_Lights"]
                peds = status_data_west["Ped_Lights"]
                pot = status_data_west["Pot_Value"]
        
                if(DEBUG):
                    print(f"[Step {step}] RX Success: {raw_str}")
                    print(f"    Cars: {cars} | Peds: {peds} | Pot: {pot}")

                if(pot > 0):
                    generate_cars_west(pot)        
                new_phase = parse_status_to_sumo_phase(status_data_west, TL_West_sumo_to_hw_index, 2)

                if(DEBUG):
                    print(f"Step {step}: Applying Phase {new_phase}")
                
                traci.trafficlight.setRedYellowGreenState(TL_ID, new_phase)
            else:
                if(DEBUG):
                    print(f"Step {step}: No update received.")
                pass

            # ================= EAST INTERSECTION =================
            get_traffic_values(TL_EAST_TRAFFIC_VALUES, TLEast_Lane_Dictionary)

            if(DEBUG):
                print(f"\n[Step {step}] TX Traffic Counts EAST (Total {len(TL_EAST_TRAFFIC_VALUES)} lanes):")
                print(f"    Raw Counts: {TL_EAST_TRAFFIC_VALUES}")
            
            # 1. FLUSH BUFFER AGAIN
            ser.reset_input_buffer()

            # Send data to Traffic Control Device
            packet = build_transmission_packet(TL_EAST_TRAFFIC_VALUES)
            send_data_chunks(ser, packet)

            # Wait for response (Requesting 'E')
            status_data_east = receive_traffic_state(ser, 'E')

            # Change Phase
            if status_data_east:
                raw_str = status_data_east["Raw_String"]
                cars = status_data_east["Car_Lights"]
                peds = status_data_east["Ped_Lights"]
                pot = status_data_east["Pot_Value"]

                if(DEBUG):
                    print(f"[Step {step}] RX Success: {raw_str}")
                    print(f"    Cars: {cars} | Peds: {peds} | Pot: {pot}")
                
                new_phase = parse_status_to_sumo_phase(status_data_east, TL_East_sumo_to_hw_index, 2)

                if(DEBUG):
                    print(f"Step {step}: Applying Phase {new_phase}")
                
                traci.trafficlight.setRedYellowGreenState(TL_EAST_ID, new_phase)
            else:
                if(DEBUG):
                    print(f"Step {step}: No update received.")
                pass

            step += 1
            
            # Ensure the loop doesn't run faster than 0.3s
            if(FREQUENCY_CONTROL):
                elapsed = time.time() - start_time
                if elapsed < 0.3:
                    time.sleep(0.3 - elapsed)

    except KeyboardInterrupt:
        print("\nStopping...")
    finally:
        traci.close()
        if ser.is_open:
            ser.close()
        print("Simulation Ended.")

if __name__ == "__main__":
    main()