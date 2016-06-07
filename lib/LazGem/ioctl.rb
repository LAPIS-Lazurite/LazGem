
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
		ret = @@device_wr.ioctl(0x1003,ch)
	end
	def get_pwr()
		pwr = 0;
		ret = @@device_wr.ioctl(0x1004,pwr)
		return ret
	end
	def set_pwr(pwr)
		ret = @@device_wr.ioctl(0x1005,pwr)
		return ret
	end
	def get_bps()
		bps = 0;
		ret = @@device_wr.ioctl(0x1006,bps)
		return ret
	end
	def set_bps(bps)
		ret = @@device_wr.ioctl(0x1007,bps)
		return ret
	end
	def get_my_addr0()
		addr = 0;
		ret = @@device_wr.ioctl(0x1008,addr)
		return ret
	end
	def get_my_addr1()
		addr = 0;
		ret = @@device_wr.ioctl(0x100a,addr)
		return ret
	end
	def get_my_addr2()
		addr = 0;
		ret = @@device_wr.ioctl(0x100c,addr)
		return ret
	end
	def get_my_addr3()
		addr = 0;
		ret = @@device_wr.ioctl(0x100e,addr)
		return ret
	end
	def get_my_panid()
		panid = 0;
		ret = @@device_wr.ioctl(0x1010,panid)
		return ret
	end
	def set_my_panid(panid)
		if panid >= 0 || panid <= 0xffff then
			ret = @@device_wr.ioctl(0x1011,panid)
			return ret
		end
	end
	def get_tx_panid()
		panid = 0;
		ret = @@device_wr.ioctl(0x1012,panid)
		return ret
	end
	def set_tx_panid(panid)
		if panid >= 0 || panid <= 0xffff then
			ret = @@device_wr.ioctl(0x1013,panid)
			return ret
		end
	end
	def get_tx_addr0()
		addr = 0;
		ret = @@device_wr.ioctl(0x1014,addr)
		return ret
	end
	def set_tx_addr0(addr)
		ret = @@device_wr.ioctl(0x1015,addr)
	end
	def get_tx_addr1()
		addr = 0;
		ret = @@device_wr.ioctl(0x1016,addr)
		return ret
	end
	def set_tx_addr1(addr)
		ret = @@device_wr.ioctl(0x1017,addr)
	end
	def get_tx_addr2()
		addr = 0;
		ret = @@device_wr.ioctl(0x1018,addr)
		return ret
	end
	def set_tx_addr2(addr)
		ret = @@device_wr.ioctl(0x1019,addr)
		return ret
	end
	def get_tx_addr3()
		addr = 0;
		ret = @@device_wr.ioctl(0x101a,addr)
		return ret
	end
	def set_tx_addr3(addr)
		ret = @@device_wr.ioctl(0x101b,addr)
	end
	def get_addr_type()
		type = 0;
		ret = @@device_wr.ioctl(0x101c,type)
		return ret
	end
	def set_addr_type(type)
		ret = @@device_wr.ioctl(0x101d,type)
	end
	def get_addr_size()
		size = 0;
		ret = @@device_wr.ioctl(0x101e,size)
		return ret
	end
	def set_addr_size(size)
		ret = @@device_wr.ioctl(0x101f,size)
	end
	def get_drv_mode()
		mode = 0;
		ret = @@device_wr.ioctl(0x1020,mode)
		return ret
	end
	def set_drv_mode(mode)
		ret = @@device_wr.ioctl(0x1021,mode)
		return ret
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

