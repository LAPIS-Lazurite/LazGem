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

laz.init()

ch = 24
panid = 0xabcd
baud = 100
pwr = 20
line = 0

while finish_flag == 0 do

	if (line == 0) then
		for i in 24..60 do
			if (i == 32) then
				next
			end
			ch = i.to_i
			printf("%3d|",ch)
		end
		printf("\n")
		printf("------------------------------------------------------------------------------------------------------------------------------------------------\n")
	end

	for i in 24..60 do
		if (i == 32) then
			next
		end
		ch = i.to_i
		laz.begin(ch,panid,baud,pwr)
		laz.rxEnable()
		sleep 0.01
		val = laz.getEdValue()
		if (val == 0) then
			printf("   |")
		else
			printf("%3d|",val)
		end
	end
	printf("\n")

	if (line == 50) then
		line=0
	else
		line+=1
	end

end

laz.close()
laz.remove()
