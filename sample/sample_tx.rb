#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require './lazurite'

laz = LazGem::Device.new

#laz.open(ch=10)
#laz.open()
##laz.open(ch=24)

finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}

laz.device_open()

while finish_flag == 0 do
	tx = Hash["rxAddr" => 0x902b]
	tx["payload"] = "Welcome SubGHz\n"
	laz.write(tx)
end

laz.device_close()


