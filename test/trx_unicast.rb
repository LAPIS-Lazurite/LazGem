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

MiniTest::Reporters.use!

class TestClass < Minitest::Test
	def setup
		@@laz = LazGem::Device.new
		begin
			p "device close"
			@@laz.remove()
		rescue
		end
	end

	def test_phy
        @@laz.init(module_test = 0x3000) #MACH:0x4000, MACH:0x2000, PHY:0x1000
        printf("input channel number(24-60):")
		ch = gets().to_i
        printf("input sleep time(sec:ex 0.5):")
		sl_time = gets().to_f
        @@laz.begin(ch,0xabcd,100,20)
        @@laz.rxEnable()

        for num in 1..100 do
            begin 
                status = @@laz.send(0xabcd,0x5F6B,"LAPIS Lazurite RF system")
            rescue
                printf("No.%d:TX FAIL\n",num)
            else
                printf("No.%d:TX SUCCEESS\n",num)
            ensure
                sleep(sl_time)
            end

            i = @@laz.available()
            if i != 0 then
                rcv = @@laz.read()
                p rcv
            end
        end

        @@laz.remove()
	end
end

