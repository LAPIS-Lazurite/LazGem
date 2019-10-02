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

lzgw_dev = "/dev/lzgw"
#system("sudo chmod 777 "+lzgw_dev)
@@device_rd = open(lzgw_dev,"rb")
@@device_wr = open(lzgw_dev,"wb")
@@device_wr.sync = true
@@device_rd.sync = true
#
#laz.init()
#laz.begin(42,0xabcd,100,20)
#laz.rxEnable()
p laz.rf_reg_read(0x6c)
p laz.rf_reg_read(0x24)
p laz.rf_reg_read(0x25)
p laz.rf_reg_read(0x26)
p laz.rf_reg_read(0x27)
p laz.rf_reg_read(0x2a)
p laz.rf_reg_read(0x2b)
p laz.rf_reg_read(0x2c)
p laz.rf_reg_read(0x2d)

