#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require '../lib/LazGem'

laz = LazGem::Device.new

# Halt process when CTRL+C is pushed.
finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}
# open device deriver
# 
# LAZURITE.open(ch=36,panid=0xabcd,pwr=20,rate=100),mode=2)
# parameter
#  ch:		frequency 24-61. 36 is in default
#  panid:	pan id
#  pwr:		tx power
#  rate:	bit rate  50 or 100
#  pwr:		tx power  1 or 20
#  mode:	must be 2
laz.device_open()

# main routine
#p laz.get_ch()
#laz.set_ch(32)
#p laz.get_ch()

#sleep 0.1

#p laz.get_pwr()
#laz.set_pwr(1)
#p laz.get_pwr()

#sleep 0.1

#p laz.get_bps()
#laz.set_bps(50)
#p laz.get_bps()

#print(sprintf("%02x\n",laz.get_panid()))
#laz.set_panid(0xffff)
#print(sprintf("%02x\n",laz.get_panid()))

print(sprintf("%02x\n",laz.rf_reg_read(2)))
print(sprintf("%02x\n",laz.rf_reg_read(3)))
laz.rf_reg_write(3,9)
print(sprintf("%02x\n",laz.rf_reg_read(3)))

print(sprintf("%02x\n",laz.eeprom_read(0x20)))
print(sprintf("%02x\n",laz.eeprom_read(0x21)))
print(sprintf("%02x\n",laz.eeprom_read(0x22)))
print(sprintf("%02x\n",laz.eeprom_read(0x23)))
print(sprintf("%02x\n",laz.eeprom_read(0x24)))
print(sprintf("%02x\n",laz.eeprom_read(0x25)))
print(sprintf("%02x\n",laz.eeprom_read(0x26)))
print(sprintf("%02x\n",laz.eeprom_read(0x27)))

# finishing process
laz.device_close()


