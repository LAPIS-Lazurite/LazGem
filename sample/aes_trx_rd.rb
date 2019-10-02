#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require_relative '../lib/LazGem'
#require 'LazGem'
require 'logger'
require 'fileutils'

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
	printf("  ch:    24-61\n")
	printf("  panid: 0-0xffff\n")
	printf("  dst..: distination address\n")
	printf("  baud:  50 or 100\n")
	printf("  pwr:   1 or 20\n")
	exit 0
end

#key = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c]
#
# open device deriver
#laz.init(module_test = 0x4000) #MACH:0x4000, MACH:0x2000, PHY:0x1000
#laz.init(0x6000)
laz.init()

dst_short_addr = 0x444a
ch = 36
panid = 0xabcd
baud = 100
pwr = 20
tim = 0

if ARGV.size > 0
	ch=Integer(ARGV[0])
end
if ARGV.size > 1
	panid = Integer(ARGV[1])
end
if ARGV.size > 2
	dst_short_addr = Integer(ARGV[2])
end
if ARGV.size > 3
	baud = Integer(ARGV[3])
end
if ARGV.size > 4
	pwr = Integer(ARGV[4])
end

t = Time.now
date = sprintf("%04d%02d%02d%02d%02d",t.year,t.mon,t.mday,t.hour,t.min)
logfilename = "log/" + date + "_aes_trx.log"
log = Logger.new(logfilename)

#key = "2b7e151628aed2a6abf7158809cf4f3c"
key = "2b7e151628aed2a6abf7158809cf4f30"
laz.setKey(key)

# main routine
begin
  laz.begin(ch,panid,baud,pwr)
  laz.rxEnable()
rescue Exception => e
   p "file io error!! reset driver"
   laz.remove()
   laz.init()
end

display=0
while finish_flag == 0 do
	begin
		if laz.available() > 0
			rcv = laz.read()
			#p rcv
			print(sprintf("rx_time= %s\trx_nsec=%d\trssi=%d %s\n",Time.at(rcv["sec"]),rcv["nsec"],rcv["rssi"],rcv["payload"]));
#		else
			msg = laz.send(panid,dst_short_addr,"LAPIS Lazurite RF system")
		end
		if (display > 10000)
			p "AES testing"
			display=0
		else
			display+=1
		end
	rescue Exception => e
		p e
    log.info(sprintf("%s",e))
		sleep 1
	end
  sleep(tim)
end

laz.close()
laz.remove()
