#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require_relative '../lib/LazGem'
#require 'LazGem'

laz = LazGem::Device.new

# Halt process when CTRL+C is pushed.
finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}

ch = 24
dst_addr = 0xffff
panid = 0xabcd
baud = 200
pwr = 20

#print(sprintf("myAddress=0x%016x\n",laz.getMyAddr64()))
#print(sprintf("myAddress=0x%04x\n",laz.getMyAddress()))

laz.init(module_test = 0x7000) #MACH:0x4000, MACH:0x2000, PHY:0x1000
laz.setDsssMode(1)
laz.setDsssSize(27)
sleep(1)
laz.begin(ch,panid,baud,pwr)
laz.rxEnable()

# printing header of receiving log
print(sprintf("time\t\t\t\t\t[ns]\trxPanid\trxAddr\ttxAddr\trssi\tpayload\n"))
print(sprintf("------------------------------------------------------------------------------------------\n"))

# main routine
while finish_flag == 0 do
	if laz.available() <= 0
		next
	end
	rcv = laz.read()
	# printing data
	p rcv
end
laz.rxDisable()

# finishing process
laz.remove()


