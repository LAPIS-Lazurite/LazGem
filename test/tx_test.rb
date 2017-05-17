#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require_relative '../lib/LazGem'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

# Halt process when CTRL+C is pushed.
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
#key = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c]
laz.init(module_test = 0x4000) #MACH:0x4000, MACH:0x2000, PHY:0x1000

printf("Input channel number(24-60:default:36):")
ch = gets()
if ch == "\n" then
    ch = 36
end
printf("Input sleep sec time(default:0.5):")
tim = gets()
if tim == "\n" then
    tim = 0.5
end
printf("Choose either to enable or disable AES [y|n]:")
res = gets()
case res
when /^[yY]/
    key = "2b7e151628aed2a6abf7158809cf4f3c"
    laz.setAes(key)
end
printf("Choose sending type 1:unicast, 2:broadcast:")
type = gets().to_i
case type
when 1
    panid = 0xabcd
    daddr = 0xac48
else
    panid = 0xffff
    daddr = 0xffff
end

laz.begin(ch,0xabcd,100,20)
#print(sprintf("myAddress=0x%04x\n",laz.getMyAddress()))
#laz.rxEnable()


# main routine
for num in 1..10 do
    begin 
        laz.send(panid,daddr,"LAPIS Lazurite RF system")
    rescue
        printf("No.%d:TX FAIL\n",num)
    else
        printf("No.%d:TX SUCCEESS\n",num)
    ensure
        sleep(tim)
    end
end
# finishing process
laz.remove()


