#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require '../lib/LazGem'

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
laz.init()
print(sprintf("myAddress=0x%04x\n",laz.getMyAddress()))

# printing header of receiving log
print(sprintf("time\t\t\t\trxPanid\trxAddr\ttxAddr\trssi\tpayload\n"))
print(sprintf("------------------------------------------------------------------------------------------\n"))

# main routine
while finish_flag == 0 do
	begin
	laz.begin(33,0xABCD,100,20)
	laz.send(0xabcd,0x904d,"hello pi gateway\n")
	laz.close()
	rescue => e
	p e
	end
	sleep 0.1
end

# finishing process
laz.remove()


