"""
Module Z3/EV functions
"""

import serial, parallel, time

def open_serial_port(port):
	try:
		s = serial.Serial(port=port, baudrate=1200, rtscts=1)
		return s
	except:
		return None

def open_parallel_port():
	try:
		p = parallel.Parallel()
		return p
	except:
		return None

def write_serial(port, data):
    " Write binary data to module using the serial port "
    s = open_serial_port(port)
    if s:
        if not s.isOpen():
            s.open()
        if s.isOpen():
            s.write(data)
            s.flush()
            s.close()
      	return True
    return False

def set_parallel(v,t=0.5):
	p = open_parallel_port()
	if p:
		p.setData(v)
		time.sleep(t)
		p.setData(0)
		return True
	return False

def reset():
	return set_parallel(1)

def load():
	return set_parallel(2)

def run():
	return set_parallel(4)

