#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require_relative '../lib/LazGem'

laz = LazGem::Device.new

# Halt process when CTRL+C is pushed.
finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}

# open device deriver

dst_addr = 0xffff
ch = 36
panid = 0xabcd
baud = 100
pwr = 20

laz.init()
laz.rf_reg_write(0)
p laz.rf_reg_read(0x24)
p laz.rf_reg_read(0x25)
p laz.rf_reg_read(0x26)
p laz.rf_reg_read(0x27)
p laz.rf_reg_read(0x2a)
p laz.rf_reg_read(0x2b)
p laz.rf_reg_read(0x2c)
p laz.rf_reg_read(0x2d)
p laz.rf_reg_read(0x6c)


print(sprintf("myAddress=0x%016x\n",laz.getMyAddr64()))
print(sprintf("myAddress=0x%04x\n",laz.getMyAddress()))


# printing header of receiving log
# finishing process


