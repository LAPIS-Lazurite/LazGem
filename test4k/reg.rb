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
	printf("ex: ./rx.rb 24 0xabcd 0x1234 200 20 0x13\n")
	exit 0
end

ch = 24
panid = 0xabcd
dst_addr = 0xffff
baud = 100
pwr = 20
mod = 0

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
#   mod = ARGV[5]
end

# open device deriver
#laz.init()
laz.init(module_test = 0x7000) #MACH:0x4000, MACH:0x2000, PHY:0x1000

#payload = "LAPIS Lazurite RF system"
payload = "LazuriteLazurite"

if mod != 0 then
    laz.setModulation(mod)
    laz.setDsssSize(16,0)
    laz.setDsssSpreadFactor(64)
end

laz.begin(ch,panid,baud,pwr)

while 1
    print("Input command(ex: w,0x0b,0x09):")
    com = STDIN.gets().split(",")

    if com[0] == "r" then
        p com[0]
        p com[1].chomp

        data = laz.rf_reg_read(com[1].chomp.to_i(16))
        printf("read data: 0x%x\n",data)
    elsif com[0] == "w" then
        p com[0]
        p com[1].chomp
        p com[2].chomp

        laz.rf_reg_write(com[1].chomp.to_i(16),com[2].chomp.to_i(16))
    else
        break
    end
end

# finishing process
laz.remove()

