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
    print("Input command(ex: w,0x0b,0x09):")
    com = gets().split(",")

    if com[0] == "r" then
        p com[0]
        p com[1].chomp

        data = laz.rf_reg_read(com[1].chomp.to_i(16))
        printf("read data: %x\n",data)
    elsif com[0] == "w" then
        p com[0]
        p com[1].chomp
        p com[2].chomp

        laz.rf_reg_write(com[1].chomp.to_i(16),com[2].chomp.to_i(16))
    else
        break
    end
end

sleep 1

# finishing process
laz.remove()
