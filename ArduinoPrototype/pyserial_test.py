import serial
import time
import struct

SERIAL_PORT = 'COM21' 
BAUD_RATE = 9600
CHUNK_SIZE = 8
START_STOP_DELIMITER = 0xFF 
PADDING_BYTE = 0x00       

# --- Data to Send ---
# Example: Variable length message with 16 actual traffic values
# The total message size will be: 1 (start 0xFF) + 16 (data) + 1 (stop 0xFF) = 18 bytes
ACTUAL_TRAFFIC_VALUES = [
    10, 20, 30, 40, 50, 60, 70, 80,
    91, 102, 113, 124, 135, 146, 157, 168
]

encoded_data = [val + 1 for val in ACTUAL_TRAFFIC_VALUES]


full_message_body = [START_STOP_DELIMITER] + encoded_data + [START_STOP_DELIMITER]

# --- 2. Chunking and Padding ---

# Calculate how many padding bytes are needed to make the message an exact multiple of CHUNK_SIZE
message_length = len(full_message_body)
padding_needed = (CHUNK_SIZE - (message_length % CHUNK_SIZE)) % CHUNK_SIZE

# Apply padding (using 0x00, which is reserved and ignored by the Arduino's data correction)
padded_message = full_message_body + [PADDING_BYTE] * padding_needed

# The final list of bytes to send (must be converted to a bytes object)
bytes_to_send = bytes(padded_message)

print(f"Message Length (w/ delimiters): {message_length} bytes")
print(f"Padding Applied: {padding_needed} bytes")
print(f"Total Transmission Size (multiple of 8): {len(bytes_to_send)} bytes")
print(f"Raw Bytes to Send (Hex): {bytes_to_send.hex()}")
print(f"Divided into {len(bytes_to_send) // CHUNK_SIZE} chunks of {CHUNK_SIZE} bytes.")
print("-" * 30)



try:
    ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
    time.sleep(2) # Give Arduino time to reset after opening the port

    for i in range(0, len(bytes_to_send), CHUNK_SIZE):
        chunk = bytes_to_send[i:i + CHUNK_SIZE]
        
        ser.write(chunk)
        print(f"Sent Chunk {i // CHUNK_SIZE + 1}: {chunk.hex()}")
        
        # Introduce a small delay to prevent buffer overruns on slow microcontrollers
        # Though the Arduino buffer is large, adding a minimal delay is good practice.
        time.sleep(0.05) 

    print("\n--- Transmission Complete ---")

except serial.SerialException as e:
    print(f"\nERROR: Could not open or communicate on port {SERIAL_PORT}.")
    print(f"Please check the port name and ensure the Arduino IDE Serial Monitor is closed.")
    print(f"Details: {e}")

finally:
    if 'ser' in locals() and ser.is_open:
        ser.close()