#! /usr/bin/python

# Simple serial binary image sender

__author__ = 'Savu Andrei <contact@andreisavu.ro>'

import serial
import sys, os

def parse_cli_params():
	if len(sys.argv) != 3:
		print 'Usage: ./sender.py <port_no> <file>'
		sys.exit(0)
	if not os.path.exists(sys.argv[2]):
		print 'File not found. Check parameters'
		sys.exit(0)
	return int(sys.argv[1]), sys.argv[2]

def open_port(port):
	try:
		s = serial.Serial(port=port, baudrate=9600, rtscts=1)
		return s
	except:
		return None
	
if __name__ == '__main__':
	port, file = parse_cli_params()
	s = open_port(port)
	if s == None:
		print 'Unable to open port'
		sys.exit(0)
		
	if not s.isOpen():
		s.open()
	
	if s.isOpen():
		print 'Writing ...'
		s.write(open(file).read())
		
		

