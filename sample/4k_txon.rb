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
if ARGV.size == 0
	printf("please input argument of ch at least\n")
	printf("command format is shown below...\n")
	printf("./sample_tx.rb ch panid dst_short_addr baud pwr\n")
	printf("ex: ./txon.rb 24 0xabcd 0x1234 200 20 0x13\n")
	exit 0
end

ch = 24
panid = 0xabcd
baud = 100
pwr = 20
mod = 0x10

if ARGV.size > 0
	ch=Integer(ARGV[0])
end
if ARGV.size > 1
	panid = Integer(ARGV[1])
end
if ARGV.size > 2
	baud = ARGV[2].to_i
end
if ARGV.size > 3
	pwr = ARGV[3].to_i
end
if ARGV.size > 4
		mod = Integer(ARGV[4])
end

# open device deriver
laz.init()
# Notes: MACH and MACL on can't broadcast.
#laz.init(module_test = 0x7000) #MACH:0x4000, MACH:0x2000, PHY:0x1000

printf("ch:%d,panid:%x,baud:%d,pwr:%d,mode:%d\n",ch,panid,baud,pwr,mod)

laz.setModulation(mod)
laz.setDsssSize(16,0)
laz.setDsssSpreadFactor(64)


laz.begin(ch,panid,baud,pwr)

print("SET TX_ON (enter):")
STDIN.gets()
laz.rf_reg_write(0x0b,0x09)
sleep 0.5

print("SET PN9 modulation (enter):")
STDIN.gets()
laz.rf_reg_write(0x76,0x03)
sleep 0.5

data = laz.rf_reg_read(0x0b)
printf("read data: %x\n",data)

print("SET TRX_OFF (enter):")
STDIN.gets()
laz.rf_reg_write(0x0b,0x08)
laz.close()
sleep 0.5

laz.remove()

