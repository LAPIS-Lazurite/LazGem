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
dst_addr = 0xffff
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
	dst_addr = Integer(ARGV[2])
end
if ARGV.size > 3
#   baud = Integer(ARGV[3])
    baud = ARGV[3].to_i
end
if ARGV.size > 4
#   pwr = Integer(ARGV[4])
    pwr = ARGV[4].to_i
end
if ARGV.size > 5
		mod = Integer(ARGV[5])
end

# open device deriver
laz.init()
# Notes: MACH and MACL on can't broadcast.
#laz.init(module_test = 0x7000) #MACH:0x4000, MACH:0x2000, PHY:0x1000

printf("ch:%d,panid:%x,dst_addr:%x,baud:%d,pwr:%d,mode:%d\n",ch,panid,dst_addr,baud,pwr,mod)

laz.setModulation(mod)
laz.setDsssSize(16,0)
laz.setDsssSpreadFactor(64)


#print("Input channel number(24- 60: or 0 exit):")
#ch = STDIN.gets().chomp.to_i

laz.begin(ch,0xabcd,baud,pwr)

print("Execute TX_ON:")
STDIN.gets()
laz.rf_reg_write(0x0b,0x09)
sleep 0.5

print("Execute modulation:")
STDIN.gets()
laz.rf_reg_write(0x76,0x03)
sleep 0.5

data = laz.rf_reg_read(0x0b)
printf("read data: %x\n",data)

print("Execute TRX_OFF:")
STDIN.gets()
laz.rf_reg_write(0x0b,0x08)
laz.close()
sleep 0.5

# finishing process
laz.remove()

