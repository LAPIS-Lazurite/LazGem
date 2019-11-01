#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
#require 'LazGem'
require_relative '../lib/LazGem'
require 'logger'
require 'fileutils'

laz = LazGem::Device.new

# --- online
=begin
lzgw_dev = "/dev/lzgw"
#system("sudo chmod 777 "+lzgw_dev)
@@device_rd = open(lzgw_dev,"rb")
@@device_wr = open(lzgw_dev,"wb")
@@device_wr.sync = true
@@device_rd.sync = true
=end

# ---- offline
laz.init()
laz.begin(42,0xabcd,100,20)
laz.rxEnable()

sleep 1
for addr in 32..47
	val = laz.eeprom_read(addr)
	p "0x" + addr.to_s(16) + ":0x" + val.to_s(16)
end

laz.close()
laz.remove()
