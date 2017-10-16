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
	printf("ex: ./rx.rb 24 0xabcd 0x1234 100 20 0\n")
	exit 0
end

ch = 36
panid = 0xabcd
dst_addr = 0xffff
baud = 100
pwr = 20

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
#	mod = Integer(ARGV[5])
    mod = ARGV[5]
end

# open device deriver
#laz.init()
# Notes: MACH and MACL on can't broadcast.
laz.init(module_test = 0x1000) #MACH:0x4000, MACL:0x2000, PHY:0x1000

printf("ch:%d,panid:%x,dst_addr:%x,baud:%d,pwr:%d,mode:%d\n",ch,panid,dst_addr,baud,pwr,mod)

if mod == "1" then
    laz.setDsssMode(1)
    laz.setDsssSize(27)
end

#payload = "LAPIS Lazurite RF system"
#payload = "LazuriteLazurite"
payload = "Welcome to Lazurite Sub-GHz"

i = 0
# main routine
while finish_flag == 0 do
#	begin
	laz.begin(ch,panid,baud,pwr)
#	rescue Exception => e
#		p "file io error!! reset driver"
#		laz.remove()
#		laz.init()
#	end
	begin
	laz.send(panid,dst_addr,payload)
	rescue Exception => e
		p e
		sleep 1
	end
	laz.close()
	sleep(0.3)
end

# finishing process
laz.remove()


