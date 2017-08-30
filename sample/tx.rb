#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
#require 'LazGem'
require 'LazGem'

laz = LazGem::Device.new

# Halt process when CTRL+C is pushed.
finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}

# open device deriver
laz.init()
#laz.init(module_test = 0x7000) #MACH:0x4000, MACH:0x2000, PHY:0x1000

ch = 24
panid = 0xffff
addr = 0xffff
baud = 100
pwr = 20

# main routine
while finish_flag == 0 do
	begin
	laz.begin(ch,0xabcd,baud,pwr)
	rescue Exception => e
		p "file io error!! reset driver"
		laz.remove()
		laz.init()
	end
	begin
	#	laz.send(panid,addr,"LAPIS Lazurite RF system")
		laz.send(0xffff,0xffff,"LAPIS Lazurite RF system")
	rescue Exception => e
		p e
		sleep 1
	end
	laz.close()
	sleep 1.000
end

# finishing process
laz.remove()


