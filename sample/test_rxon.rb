#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require '../lib/LazGem'

laz = LazGem::Device.new

finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}

#laz.device_open()
#device open in test mode of MODE_STREAM
laz.device_open(mode:0x0202)
#laz.device_open()


print ("set rxon\n")
begin
	laz.rxon()
rescue => e
	p e
end

print ("set rfoff\n")
begin
	laz.rxoff()
rescue => e
	p e
end

laz.device_close()

