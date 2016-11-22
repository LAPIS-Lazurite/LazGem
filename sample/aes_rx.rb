#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
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
#key = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c]
key = "2b7e151628aed2a6abf7158809cf4f3c"

laz.init()
laz.setAes(key)
laz.begin(42,0xABCD,100,20)
print(sprintf("myAddress=0x%04x\n",laz.getMyAddress()))
laz.rxEnable()

# printing header of receiving log
print(sprintf("time\t\t\t\trxPanid\trxAddr\ttxAddr\trssi\tpayload\n"))
print(sprintf("------------------------------------------------------------------------------------------\n"))

# main routine
while finish_flag == 0 do
	if laz.available() <= 0
		next
	end
	rcv = laz.read()
	# printing data
	#p rcv
	print(sprintf("rx_time= %s\trx_nsec=%d\trssi=%d %s\n",Time.at(rcv["sec"]),rcv["nsec"],rcv["rssi"],rcv["payload"]));
end

# finishing process
laz.remove()


