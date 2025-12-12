import serial
import time
import struct
import binascii

# --- Configuration ---
SERIAL_PORT = 'COM21' 
BAUD_RATE = 9600
CHUNK_SIZE = 8
START_STOP_DELIMITER = 0xFF 
PADDING_BYTE = 0x00
RECEIVE_TIMEOUT = 5  # Timeout for reading in seconds

# --- Data to Send (Your Existing Protocol) ---
ACTUAL_TRAFFIC_VALUES = [
    10, 20, 30, 40, 50, 60, 70, 80,
    91, 102, 113, 124, 135, 146, 157, 168
]

# --- Protocol Functions ---

def build_transmission_packet(values):
    """Encodes and chunks the traffic values for transmission."""
    encoded_data = [val + 1 for val in values]
    full_message_body = [START_STOP_DELIMITER] + encoded_data + [START_STOP_DELIMITER]

    message_length = len(full_message_body)
    padding_needed = (CHUNK_SIZE - (message_length % CHUNK_SIZE)) % CHUNK_SIZE
    padded_message = full_message_body + [PADDING_BYTE] * padding_needed
    
    bytes_to_send = bytes(padded_message)
    
    print(f"  [TX] Message Size: {message_length} bytes. Total Chunks: {len(bytes_to_send) // CHUNK_SIZE}")
    return bytes_to_send

def send_data_chunks(ser, bytes_to_send):
    """Sends the prepared byte sequence in 8-byte chunks."""
    for i in range(0, len(bytes_to_send), CHUNK_SIZE):
        chunk = bytes_to_send[i:i + CHUNK_SIZE]
        ser.write(chunk)
        # print(f"  [TX] Sent Chunk {i // CHUNK_SIZE + 1}: {binascii.hexlify(chunk)}")
        time.sleep(0.01) # Small inter-chunk delay for safety

def receive_traffic_state(ser):
    """Reads a length-prefixed packet from the Arduino."""
    
    try:
        # 1. Read the Length Byte (1 byte)
        length_byte = ser.read(1)
        
        if not length_byte:
            # Normal timeout (no data sending currently)
            return None
            
        packet_size = int.from_bytes(length_byte, byteorder='big')
        
        # Sanity Check: If size is unreasonable (e.g., > 64 or 0), we might be out of sync
        if packet_size < 5 or packet_size > 64:
             print(f"  [RX] Warning: Invalid packet size read ({packet_size}). Out of sync?")
             ser.reset_input_buffer() # Flush garbage
             return None

        # 2. Read exactly 'packet_size' bytes
        data = ser.read(packet_size)
        
        # Check if we got the full payload
        if len(data) != packet_size:
            print(f"  [RX] Error: Expected {packet_size} bytes, got {len(data)}")
            return None

        # 3. Decode and Parse
        try:
            received_string = data.decode('ascii')
        except UnicodeDecodeError:
            print(f"  [RX] Error: Non-ASCII data in payload: {data}")
            return None

        # 4. Validate Framing (The payload inside should still match your protocol)
        if received_string[0] != '$' or received_string[-1] != '$':
             print(f"  [RX] Error: Malformed payload: {received_string}")
             return None

        # 5. Parse Statuses (Adjust indices based on your string structure)
        statuses = {
            "Car_Lights": received_string[1:18], 
            "Ped_Light_1": received_string[18],  
            "Ped_Light_2": received_string[19], 
            "Raw_String": received_string
        }
        
        print(f"  [RX] Success. Size: {packet_size}. Status: {statuses['Car_Lights']}")
        return statuses

    except Exception as e:
        print(f"  [RX] General error: {e}")
        return None

# --- Main Execution ---

if __name__ == "__main__":
    bytes_to_send = build_transmission_packet(ACTUAL_TRAFFIC_VALUES)
    
    try:
        # Set a low timeout on the serial object for faster non-blocking receive checks
        ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=0.1) 
        time.sleep(2) # Initial reset delay

        print("\n--- Starting Full Duplex Communication ---")
        
        while True:
            cycle_start_time = time.time()

            # 1. SEND DATA TO ZYNQ (Commanding New Traffic Values)
            print("\n[CYCLE START] Sending new traffic values...")
            send_data_chunks(ser, bytes_to_send)
            
            # 2. WAIT FOR ZYNQ TO PROCESS and SEND STATUS BACK
            # We assume the Zynq processes the received data and immediately 
            # sends its status (the ASCII string) as a response.
            time.sleep(0.5) # Give Zynq time to process the command and generate the status output

            # 3. RECEIVE STATUS FROM ZYNQ
            print("[STATUS] Waiting for Zynq response...")
            status_data = receive_traffic_state(ser)
            
            # 4. Process Status (Optional)
            if status_data:
                print(f"[PROCESS] Zynq Status: {status_data['Ped_Light_1']}{status_data['Ped_Light_2']}")
            
            # 5. Enforce 1-second Cycle Time (Total time between transmissions)
            time_elapsed = time.time() - cycle_start_time
            delay_time = 1.0 - time_elapsed
            
            if delay_time > 0:
                time.sleep(delay_time)
                
    except serial.SerialException as e:
        print(f"\nFATAL ERROR: Could not open or communicate on port {SERIAL_PORT}.")
        print(f"Details: {e}")
        
    except KeyboardInterrupt:
        print("\nInterrupted by user. Exiting.")

    finally:
        if 'ser' in locals() and ser.is_open:
            ser.close()