#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
#require 'LazGem'
require_relative '../lib/LazGem'

laz = LazGem::Device.new

# Halt process when CTRL+C is pushed.
finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}

# open device deriver
#laz.init()
laz.init(module_test = 0x7000) #MACH:0x4000, MACH:0x2000, PHY:0x1000

ch = 36
panid = 0xabcd
addr = 0x1234
baud = 100
pwr = 20
#payload = "LAPIS Lazurite RF system"
payload = "LazuriteLazurite"

laz.setDsssMode(0)
laz.setDsssSize(0)

while 1
    print("Input channel number(24- 60):")
    ch = gets().to_i
    laz.begin(ch,0xabcd,baud,pwr)

    print("Request TX_ON:")
    gets()
    laz.rf_reg_write(0x0b,0x09)
    sleep 1

    data = laz.rf_reg_read(0x0b)
    printf("read data: %x\n",data)

    print("Request TRX_OFF:")
    gets()
    laz.rf_reg_write(0x0b,0x08)
    laz.close()
    sleep 1
end


# finishing process
laz.remove()
