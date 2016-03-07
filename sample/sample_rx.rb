#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require 'LazGem'

laz = LazGem::Device.new

# Halt process when CTRL+C is pushed.
finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}
# open device deriver
# 
# LAZURITE.open(ch=36,panid=0xabcd,pwr=20,rate=100),mode=2)
# parameter
#  ch:		frequency 24-61. 36 is in default
#  panid:	pan id
#  pwr:		tx power
#  rate:	bit rate  50 or 100
#  pwr:		tx power  1 or 20
#  mode:	must be 2
laz.device_open()

# printing header of receiving log
print(sprintf("time\t\t\t\trxPanid\trxAddr\ttxAddr\trssi\tpayload\n"))
print(sprintf("------------------------------------------------------------------------------------------\n"))

# main routine
while finish_flag == 0 do
	rcv = laz.read()
	if rcv == -1 then
		next
	end
	# printing data
	print(sprintf("%s.%06d\t0x%04X\t0x%04X\t0x%04X\t%03d\t%s",
		rcv["Time"].strftime("%Y-%m-%d %H:%M:%S"),
		rcv["usec"],
		rcv["rxPanid"],
		rcv["rxAddr"],
		rcv["txAddr"],
		rcv["rssi"],
		rcv["payload"].unpack("a*")[0]))
end

# finishing process
laz.device_close()


