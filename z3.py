"""
Module Z3/EV functions
"""

import serial

def open_port(port):
	try:
		s = serial.Serial(port=port, baudrate=1200, rtscts=1)
		return s
	except:
		return None

def write_serial(port, data):
    " Write binary data to module using the serial port "
    s = open_port(port)
    if s:
        if not s.isOpen():
            s.open()
        if s.isOpen():
            s.write(data)
        return True
    return False
