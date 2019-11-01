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
p laz.tx_led(1)
sleep 1
p laz.rx_led(1)

laz.close()
laz.remove()
