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
print(sprintf("default ch=%d\n",laz.get_ch()))
laz.set_ch(32)
print(sprintf("ch is changed to 32. then %d\n",laz.get_ch()))

print(sprintf("default pwr=%d\n",laz.get_pwr()))
laz.set_pwr(1)
print(sprintf("pwr is changed to 1. then %d\n",laz.get_pwr()))

print(sprintf("default bps=%d\n",laz.get_bps()))
laz.set_bps(50)
print(sprintf("bps is changed to 50. then %d\n",laz.get_bps()))

print(sprintf("%02x\n",laz.get_my_panid()))
laz.set_my_panid(0xffff)
print(sprintf("%02x\n",laz.get_my_panid()))

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

laz.tx_led(1)
laz.rx_led(1)

# finishing process
laz.device_close()


