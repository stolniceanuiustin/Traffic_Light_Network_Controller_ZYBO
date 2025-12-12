import sys
import os
import serial
import time
import struct
import binascii

# ==== SUMO CONFIGURATION ==== #
SUMO_TOOLS = r"C:\Program Files (x86)\Eclipse\Sumo\tools"
if SUMO_TOOLS not in sys.path:
    sys.path.append(SUMO_TOOLS)

import traci

SUMO_BINARY = "sumo-gui"
CONFIG_FILE = "mysim.sumocfg"
SIM_DURATION = 3600
TL_ID = "TL_WEST"
DEBUG = True
FREQUENCY_CONTROL = False

# ==== SERIAL CONFIGURATION ==== 
SERIAL_PORT = 'COM21' 
BAUD_RATE = 9600
CHUNK_SIZE = 8
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

TL_West_Downstream_Lanes = [0,1,5,6,11,12,13]

# Mapping SUMO Signal Index (0-13) -> Hardware Lane ID
# #l16 l15 l14 l7 l7 l9 l10 l10 l4 l3 l2 l2 ped1 ped2
# Note: Peds are handled separately at the end of the loop. Pedestrians are not simulated by SUMO but by buttons
TL_West_sumo_to_hw_index = [16, 15, 14, 7, 7, 9, 10, 10, 4, 3, 2, 2]


# ==== HELPER FUNCTIONS ==== #

def build_transmission_packet(values):
    """Encodes and chunks the traffic values for transmission"""
    encoded_data = [val + 1 for val in values]
    full_message_body = [START_STOP_DELIMITER] + encoded_data + [START_STOP_DELIMITER]

    message_length = len(full_message_body)
    padding_needed = (CHUNK_SIZE - (message_length % CHUNK_SIZE)) % CHUNK_SIZE
    padded_message = full_message_body + [PADDING_BYTE] * padding_needed
    
    bytes_to_send = bytes(padded_message)
    if(DEBUG):
        print(f" [TX] Message Size: {message_length} bytes.")
    return bytes_to_send

def send_data_chunks(ser, bytes_to_send):
    """Sends the prepared byte sequence in 8-byte chunks."""
    for i in range(0, len(bytes_to_send), CHUNK_SIZE):
        chunk = bytes_to_send[i:i + CHUNK_SIZE]
        ser.write(chunk)
        time.sleep(0.005) # Tiny delay for stability

Lane_Cnt_Dict = {
    "TL_West": (17, 2),
    "TL_East": (16, 2)
}

def receive_traffic_state(ser):
    """ Reads a length-prefixed packet from the Arduino. The format is the following:
        (package_length)(W\E - based on what int. we want to control)(traffic_data)(W\E)
    """
    try:
        # 1. Read the Length Byte (1 byte)
        length_byte = ser.read(1)
        
        if not length_byte:
            return None # Timeout
            
        packet_size = int.from_bytes(length_byte, byteorder='big')
        
        # Sanity Check
        if packet_size < 5 or packet_size > 64:
             print(f" [RX] Warning: Invalid packet size ({packet_size}). Flushing.")
             ser.reset_input_buffer()
             return None

        # 2. Read exactly 'packet_size' bytes
        data = ser.read(packet_size)
        
        if len(data) != packet_size:
            print(f" [RX] Error: Expected {packet_size} bytes, got {len(data)}")
            return None

        # 3. Decode
        try:
            received_string = data.decode('ascii')
        except UnicodeDecodeError:
            print(f" [RX] Error: Non-ASCII data: {data}")
            return None

        # 4. Validate Framing
        if received_string[0] != '$' or received_string[-1] != '$':
             print(f" [RX] Error: Malformed payload: {received_string}")
             return None

        # 5. Parse Statuses
        # String format: $ [17 cars] [2 peds] $
        # Indices: $ is 0. Cars are 1-17. Peds are 18-19. $ is 20.c
        car_lane_cnt = Lane_Cnt_Dict["TL_West"][0]
        ped_lane_cnt = Lane_Cnt_Dict["TL_West"][1]
        start_cars = 1
        end_cars = 1 + car_lane_cnt 
        start_peds = end_cars 
        end_peds = start_peds + ped_lane_cnt
        statuses = {
            "Car_Lights": received_string[start_cars : end_cars], 
            "Ped_Lights": received_string[start_peds : end_peds], 
            "Raw_String": received_string 
        }
        return statuses

    except Exception as e:
        print(f" [RX] General error: {e}")
        return None

def get_traffic_values(Traffic_Values, Lane_Dictionary):
    """Refreshes the Traffic_Values list with current SUMO data"""
    Traffic_Values.clear() # Clear previous step data
    
    for i in range(len(Lane_Dictionary)):
        lane_id = Lane_Dictionary.get(i)
        if lane_id:
            try:
                # count = 
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
    step = 0
    
    print(f"Running simulation for {SIM_DURATION} steps...")
    
    try:
        while step < SIM_DURATION:
            start_time = time.time()
            
            # Step Simulation
            traci.simulationStep()

            # Get Traffic Values
            get_traffic_values(TL_WEST_TRAFFIC_VALUES, TLWest_Lane_Dictionary)

            # ==== DEBUG PRINTS ======
            if(DEBUG):
                print(f"\n[Step {step}] TX Traffic Counts (Total {len(TL_WEST_TRAFFIC_VALUES)} lanes):")
                print(f"    Raw Counts: {TL_WEST_TRAFFIC_VALUES}")
            
            # Send data to Traffic Control Device (Arduino in this case)
            packet = build_transmission_packet(TL_WEST_TRAFFIC_VALUES)
            send_data_chunks(ser, packet)

            # Wait for response from traffic Control Device
            status_data_west = receive_traffic_state(ser)

            # Change Phase
            if status_data_west:
                raw_str = status_data_west["Raw_String"]
                cars = status_data_west["Car_Lights"]
                peds = status_data_west["Ped_Lights"]

                if(DEBUG):
                    print(f"[Step {step}] RX Success: {raw_str}")
                    print(f"    Cars: {cars} | Peds: {peds}")
                
                new_phase = parse_status_to_sumo_phase(status_data_west, TL_West_sumo_to_hw_index, 2)

                if(DEBUG):
                    print(f"Step {step}: Applying Phase {new_phase}")
                
                traci.trafficlight.setRedYellowGreenState(TL_ID, new_phase)
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