#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
#require 'LazGem'
require_relative '../lib/LazGem'
require 'logger'
require 'fileutils'

laz = LazGem::Device.new

# Halt process when CTRL+C is pushed.
finish_flag=0
Signal.trap(:INT){
	finish_flag=1
}

# open device deriver
#laz.init(0x6000)
laz.init()

dst_short_addr = 0x444a
ch = 36
panid = 0xabcd
baud = 100
pwr = 20


t = Time.now
date = sprintf("%04d%02d%02d%02d%02d",t.year,t.mon,t.mday,t.hour,t.min)
logfilename = "log/" + date + "_samlple_trx.log"
log = Logger.new(logfilename)

i = 0
# main routine

begin
  laz.begin(ch,panid,baud,pwr)
  laz.rxEnable()
rescue Exception => e
   p "file io error!! reset driver"
   laz.remove()
   laz.init()
end


p laz.rf_reg_read(0x6c)
#p laz.get_rx_rssi()
laz.close()
laz.remove()


