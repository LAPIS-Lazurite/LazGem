#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
#require 'LazGem'
require_relative '../lib/LazGem'

laz = LazGem::Device.new

# Halt process when CTRL+C is pushed.
finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}

# open device deriver
#laz.init()
laz.init(module_test = 0x7000) #MACH:0x4000, MACH:0x2000, PHY:0x1000

ch = 24
panid = 0xabcd
addr = 0x1234
baud = 200
pwr = 20
#payload = "LAPIS Lazurite RF system"
#payload = "LazuriteLazurite"
payload = "Welcome to Lazurite Sub-GHz"

laz.setDsssMode(1)
laz.setDsssSize(27)

# main routine
while finish_flag == 0 do
#	begin
	laz.begin(ch,0xabcd,baud,pwr)
#	rescue Exception => e
#		p e
#		p "file io error!! reset driver"
#		laz.remove()
#		laz.init()
#	end
#	begin
    sleep(0.3)
	laz.send(panid,addr,payload)
#	rescue Exception => e
#		p e
#		sleep 1
#	end
#   sleep(0.3)
	laz.close()
    sleep(0.3)
#	sleep 1.000
end

# finishing process
laz.remove()


