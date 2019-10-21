#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
#require 'LazGem'
require_relative '../lib/LazGem'
require 'logger'
require 'timeout'

laz = LazGem::Device.new

# Halt process when CTRL+C is pushed.
finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}


t = Time.now
date = sprintf("%4d%02d%%02d%02d%02d",t.year,t.mon,t.mday,t.hour,t.min)
logfilename = "log/" + "search_rssi_" + date + ".log"
$log = Logger.new(logfilename)

laz.init()

ch = 24
panid = 0xabcd
baud = 100
pwr = 20
line = 0

while finish_flag == 0 do

	str = ""
	if (line == 0) then
		for i in 24..60 do
			if (i == 32) then
				next
			end
			ch = i.to_i
			str << sprintf("%3d|",ch)
		end
		printf("%s\n",str)
		printf("------------------------------------------------------------------------------------------------------------------------------------------------\n")
	end

	str = ""
	for i in 24..60 do
		ch = i.to_i
		if (i == 32) then
			next
		end
		laz.begin(ch,panid,baud,pwr)
		laz.rxEnable()
		sleep 0.01
		val = laz.getEdValue()
		if (val == 0) then
			str << sprintf("   |")
		else
			str << sprintf("%3d|",val)
		end
	end
	printf("%s\n",str)
	if (line == 50) then
		line=0
	else
		line+=1
	end

end

laz.close()
laz.remove()
