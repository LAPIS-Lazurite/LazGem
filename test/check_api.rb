#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require_relative '../lib/LazGem'

laz = LazGem::Device.new

# Halt process when CTRL+C is pushed.
finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}

laz.init(module_test=0x4000)

dst_addr = 0xffff
ch = 36
panid = 0xabcd
baud = 100
pwr = 20

if ARGV.size > 0
	ch=Integer(ARGV[0])
end
if ARGV.size > 1
	panid = Integer(ARGV[1])
end
if ARGV.size > 2
	baud = Integer(ARGV[2])
end
if ARGV.size > 3
	pwr = Integer(ARGV[3])
end

print(sprintf("myAddress=0x%016x\n",laz.getMyAddr64()))
print(sprintf("myAddress=0x%04x\n",laz.getMyAddress()))
print(sprintf("ch=%d, panid = %04x, baud= %d, pwr=%d\n",ch,panid,baud,pwr))
laz.setMyAddress(0x0000)
laz.begin(ch,panid,baud,pwr)
laz.getMyAddress()
laz.close()
laz.setMyAddress(0xFFFE)
laz.begin(ch,panid,baud,pwr)
laz.getMyAddress()
laz.close()
begin
	laz.setMyAddress(0xFFFF)
	laz.begin(ch,panid,baud,pwr)
	laz.getMyAddress()
	laz.close()
rescue => e
	p e
end
laz.setAckReq(true)
sleep(1)
laz.setAckReq(false)

laz.remove()


