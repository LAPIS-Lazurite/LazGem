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


print ("set invalid rat number\n")
begin
	laz.set_pwr(4)
rescue => e
	p e
end

print ("set pwr\n")
begin
	laz.set_pwr(1)
rescue => e
	p e
end

print ("get pwr \n")
begin
	pwr = laz.get_pwr()
	p pwr
rescue => e
	p e
end

laz.device_close()


