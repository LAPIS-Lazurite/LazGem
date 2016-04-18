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


print ("set invalid cca cycle\n")
begin
	laz.set_cca_cycle(0x10000)
rescue => e
	p e
end

print ("set cca_cycle\n")
begin
	laz.set_cca_cycle(0x55)
rescue => e
	p e
end

print ("get cca_cycle \n")
begin
	cca_cycle = laz.get_cca_cycle()
	p cca_cycle
rescue => e
	p e
end

laz.device_close()


