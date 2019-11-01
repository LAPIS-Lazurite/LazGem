#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require_relative '../lib/LazGem'
#require 'LazGem'

laz = LazGem::Device.new

# Halt process when CTRL+C is pushed.
finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}

if ARGV.size == 0
	printf("please input argument of ch at least\n")
	printf("command format is shown below...\n")
	printf("./rx.rb ch panid addr baud pwr mod\n")
	printf("ex: ./rx.rb 24 0xabcd 0x1234 200 20 0x10 16\n")
	exit 0
end


ch = 24
addr = 0xffff
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
#   baud = Integer(ARGV[3])
    baud = ARGV[2].to_i
end
if ARGV.size > 3
#   pwr = Integer(ARGV[4])
    pwr = ARGV[3].to_i
end

laz.init()
#laz.init(module_test = 0x7000) #MACH:0x4000, MACL:0x2000, PHY:0x1000

laz.setModulation(mod)
laz.setDsssSize(16,0)
laz.setDsssSpreadFactor(64)

print(sprintf("myAddress=0x%016x\n",laz.getMyAddr64()))
print(sprintf("myAddress=0x%04x\n",laz.getMyAddress()))

laz.begin(ch,panid,baud,pwr)
laz.rxEnable()

# printing header of receiving log
print(sprintf("time\t\t\t\t\t[ns]\trxPanid\trxAddr\ttxAddr\trssi\tpayload\n"))
print(sprintf("------------------------------------------------------------------------------------------\n"))

# main routine
while finish_flag == 0 do
	if laz.available() <= 0
		next
	end
	rcv = laz.read()
	# printing data
	p rcv
end

laz.close()
laz.remove()