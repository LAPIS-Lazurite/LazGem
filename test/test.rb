#! /usr/bin/ruby
# -*- coding: utf-8; mode: ruby -*-
# Function:
#   Lazurite Sub-GHz/Lazurite Pi Gateway Sample program
#   SerialMonitor.rb
require_relative '../lib/LazGem'
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

class TestClass < MiniTest::Unit::TestCase
	def setup
		@@laz = LazGem::Device.new
		begin
			@@laz.device_close()
		rescue
		end
	end

	def test_drviver
		@@laz.device_open()
		assert_equal 100,@@laz.get_bps()
		assert_equal 36,@@laz.get_ch()
		assert_raises (Errno::EINVAL) {@@laz.set_ch(23)}
		assert_equal 24,@@laz.set_ch(24)
		assert_equal 31,@@laz.set_ch(31)
		assert_raises (Errno::EINVAL) {@@laz.set_ch(32)}
		assert_equal 33,@@laz.set_ch(33)
		assert_equal 60,@@laz.set_ch(60)
		assert_raises (Errno::EINVAL) {@@laz.set_ch(61)}
		assert_equal 60,@@laz.get_ch()

		assert_equal 50,@@laz.set_bps(50)
		assert_raises (Errno::EINVAL) {@@laz.set_ch(23)}
		assert_equal 24,@@laz.set_ch(24)
		assert_equal 31,@@laz.set_ch(31)
		assert_equal 32,@@laz.set_ch(32)
		assert_equal 33,@@laz.set_ch(33)
		assert_equal 61,@@laz.set_ch(61)
		assert_raises (Errno::EINVAL) {@@laz.set_ch(62)}
		assert_equal 61,@@laz.get_ch()

		assert_raises (Errno::EINVAL) {@@laz.set_bps(49)}
		assert_equal 50,@@laz.get_bps()
		assert_equal 100,@@laz.set_bps(100)
		assert_equal 100,@@laz.get_bps()
		assert_raises (Errno::EINVAL) {@@laz.set_bps(101)}
		assert_equal 100,@@laz.get_bps()
		@@laz.device_close()
	end

	def test_reg
		@@laz.device_open()
		for i in 1..10000 do
			assert_equal 0x9f,@@laz.rf_reg_read(2)
			assert_equal 0x04,@@laz.rf_reg_read(3)
		end
		@@laz.device_close()
	end
end

