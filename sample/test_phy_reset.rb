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


#while finish_flag == 0 do
	tx = Hash["rxAddr" => 0x902b]
	tx["payload"] = "Welcome SubGHz\n"
	#tx["ack_req"] = 0
	#tx["seq_comp"] = 1
	begin
		laz.phy_reset()
	rescue LAZURITE_ERROR
	end
#end

laz.device_close()


