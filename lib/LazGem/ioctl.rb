
# -*- coding: utf-8; mode: ruby -*-
#
# Function:
#   Lazurite Pi Gateway SubGHz library

class LazGem::Device
	def get_ch()
		ch = 0;
		ret = @@device_wr.ioctl(0x1002,ch)
		return ret
	end
	def set_ch(ch)
		if ch >= 24 || ch <= 61 then
			ret = @@device_wr.ioctl(0x1003,ch)
			return ret
		end
	end
	def get_pwr()
		pwr = 0;
		ret = @@device_wr.ioctl(0x1004,pwr)
		return ret
	end
	def set_pwr(pwr)
		if pwr == 1 || pwr == 20 then
			ret = @@device_wr.ioctl(0x1005,pwr)
			return ret
		end
	end
	def get_bps()
		bps = 0;
		ret = @@device_wr.ioctl(0x1006,bps)
		return ret
	end
	def set_bps(bps)
		if bps == 50 || bps == 100 then
			ret = @@device_wr.ioctl(0x1007,bps)
			return ret
		end
	end
	def get_panid()
		panid = 0;
		ret = @@device_wr.ioctl(0x1008,panid)
		return ret
	end
	def set_panid(panid)
		if panid >= 0 || ch <= 0xffff then
			ret = @@device_wr.ioctl(0x1009,panid)
			return ret
		end
	end
	def rf_reg_read(addr)
		data = 0;
		if addr >= 0 || addr <= 0xff then
			ret = @@device_wr.ioctl(0x2000 + addr,data)
			return ret
		end
	end
	def rf_reg_write(addr,data)
		if addr >= 0 || ch <= 0xff || data >= 0 || data <= 0xff then
			ret = @@device_wr.ioctl(0x2800+addr ,data)
			return ret
		end
	end
	def eeprom_read(addr)
		data = 0;
		if addr >= 0 || addr <= 0x0fff then
			ret = @@device_wr.ioctl(0x3000 + addr,data)
			return ret
		end
	end
	def rx_led(time)
		if time >= 0 || time <= 0xffff then
			ret = @@device_wr.ioctl(0x4000,time)
			return ret
		end
	end
	def tx_led(time)
		if time >= 0 || time <= 0xffff then
			ret = @@device_wr.ioctl(0x4001,time)
			return ret
		end
	end
end
