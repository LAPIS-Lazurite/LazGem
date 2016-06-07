
# -*- coding: utf-8; mode: ruby -*-
#
# Function:
#   Lazurite Pi Gateway SubGHz library

class LazGem::Device
	IOCTL_PARAM=		0x1000
	IOCTL_GET_CH=		IOCTL_PARAM+0x02
	IOCTL_SET_CH=		IOCTL_PARAM+0x03
	IOCTL_GET_PWR=		IOCTL_PARAM+0x04
	IOCTL_SET_PWR=		IOCTL_PARAM+0x05
	IOCTL_GET_BPS=		IOCTL_PARAM+0x06
	IOCTL_SET_BPS=		IOCTL_PARAM+0x07
	IOCTL_GET_MY_PANID=	IOCTL_PARAM+0x08
	IOCTL_SET_MY_PANID=	IOCTL_PARAM+0x09
	IOCTL_GET_TX_PANID=	IOCTL_PARAM+0x0a
	IOCTL_SET_TX_PANID=	IOCTL_PARAM+0x0b
	IOCTL_GET_MY_ADDR0=	IOCTL_PARAM+0x0c
	IOCTL_SET_MY_ADDR0=	IOCTL_PARAM+0x0d
	IOCTL_GET_MY_ADDR1=	IOCTL_PARAM+0x0e
	IOCTL_SET_MY_ADDR1=	IOCTL_PARAM+0x0f
	IOCTL_GET_MY_ADDR2=	IOCTL_PARAM+0x10
	IOCTL_SET_MY_ADDR2=	IOCTL_PARAM+0x11
	IOCTL_GET_MY_ADDR3=	IOCTL_PARAM+0x12
	IOCTL_SET_MY_ADDR3=	IOCTL_PARAM+0x13
	IOCTL_GET_TX_ADDR0=	IOCTL_PARAM+0x14
	IOCTL_SET_TX_ADDR0=	IOCTL_PARAM+0x15
	IOCTL_GET_TX_ADDR1=	IOCTL_PARAM+0x16
	IOCTL_SET_TX_ADDR1=	IOCTL_PARAM+0x17
	IOCTL_GET_TX_ADDR2=	IOCTL_PARAM+0x18
	IOCTL_SET_TX_ADDR2=	IOCTL_PARAM+0x19
	IOCTL_GET_TX_ADDR3=	IOCTL_PARAM+0x1a
	IOCTL_SET_TX_ADDR3=	IOCTL_PARAM+0x1b
	IOCTL_GET_ADDR_TYPE=IOCTL_PARAM+0x1c
	IOCTL_SET_ADDR_TYPE=IOCTL_PARAM+0x1d
	IOCTL_GET_ADDR_SIZE=IOCTL_PARAM+0x1e
	IOCTL_SET_ADDR_SIZE=IOCTL_PARAM+0x1f
	IOCTL_GET_DRV_MODE=	IOCTL_PARAM+0x20
	IOCTL_SET_DRV_MODE=	IOCTL_PARAM+0x21
	IOCTL_RF=			0x2000
	IOCTL_RF_READ=		IOCTL_RF+0x0000
	IOCTL_RF_WRITE=		IOCTL_RF+0x8000
	IOCTL_EEPROM=		0x3000
	IOCTL_RX_LED=		0x4000
	IOCTL_TX_LED=		0x4000

	def get_ch()
		ch = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_CH,ch)
		return ret
	end
	def set_ch(ch)
		ret = @@device_wr.ioctl(IOCTL_SET_CH,ch)
	end
	def get_pwr()
		pwr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_PWR,pwr)
		return ret
	end
	def set_pwr(pwr)
		ret = @@device_wr.ioctl(IOCTL_SET_PWR,pwr)
		return ret
	end
	def get_bps()
		bps = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_BPS,bps)
		return ret
	end
	def set_bps(bps)
		ret = @@device_wr.ioctl(IOCTL_SET_BPS,bps)
		return ret
	end
	def get_my_panid()
		panid = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_MY_PANID,panid)
		return ret
	end
	def set_my_panid(panid)
		ret = @@device_wr.ioctl(IOCTL_SET_MY_PANID,panid)
		return ret
	end
	def get_tx_panid()
		panid = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_TX_PANID,panid)
		return ret
	end
	def set_tx_panid(panid)
		ret = @@device_wr.ioctl(IOCTL_SET_TX_PANID,panid)
		return ret
	end
	def get_my_addr0()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_MY_ADDR0,addr)
		return ret
	end
	def set_my_addr0(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_MY_ADDR0,addr)
		return ret
	end
	def get_my_addr1()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_MY_ADDR1,addr)
		return ret
	end
	def set_my_addr1(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_MY_ADDR1,addr)
		return ret
	end
	def get_my_addr2()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_MY_ADDR2,addr)
		return ret
	end
	def set_my_addr2(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_MY_ADDR2,addr)
		return ret
	end
	def get_my_addr3()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_MY_ADDR3,addr)
		return ret
	end
	def set_my_addr3(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_MY_ADDR3,addr)
		return ret
	end
	def get_tx_addr0()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_TX_ADDR0,addr)
		return ret
	end
	def set_tx_addr0(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_TX_ADDR0,addr)
		return ret
	end
	def get_tx_addr1()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_TX_ADDR1,addr)
		return ret
	end
	def set_tx_addr1(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_TX_ADDR1,addr)
		return ret
	end
	def get_tx_addr2()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_TX_ADDR2,addr)
		return ret
	end
	def set_tx_addr2(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_TX_ADDR2,addr)
		return ret
	end
	def get_tx_addr3()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_TX_ADDR3,addr)
		return ret
	end
	def set_tx_addr3(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_TX_ADDR3,addr)
		return ret
	end
	def get_addr_type()
		type = 0
		ret = @@device_wr.ioctl(IOCTL_GET_ADDR_TYPE,type)
		return ret
	end
	def set_addr_type(type)
		ret = @@device_wr.ioctl(IOCTL_SET_ADDR_TYPE,type)
		return ret
	end
	def get_addr_size()
		size = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_ADDR_SIZE,size)
		return ret
	end
	def set_addr_size(size)
		ret = @@device_wr.ioctl(IOCTL_SET_ADDR_SIZE,size)
		return ret
	end
	def get_drv_mode()
		mode = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_DRV_MODE,mode)
		return ret
	end
	def set_drv_mode(mode)
		ret = @@device_wr.ioctl(IOCTL_SET_DRV_MODE,mode)
		return ret
	end


	def rf_reg_read(addr)
		data = 0;
		if addr >= 0 || addr <= 0xff then
			ret = @@device_wr.ioctl(IOCTL_RF_READ + addr,data)
			return ret
		end
	end
	def rf_reg_write(addr,data)
		if addr >= 0 || ch <= 0xff || data >= 0 || data <= 0xff then
			ret = @@device_wr.ioctl(IOCTL_RF_WRITE+addr ,data)
			return ret
		end
	end

	def eeprom_read(addr)
		data = 0;
		if addr >= 0 || addr <= 0x0fff then
			ret = @@device_wr.ioctl(IOCTL_EEPROM + addr,data)
			return ret
		end
	end

	def rx_led(time)
		if time >= 0 || time <= 0xffff then
			ret = @@device_wr.ioctl(IOCTL_RX_LED,time)
			return ret
		end
	end

	def tx_led(time)
		if time >= 0 || time <= 0xffff then
			ret = @@device_wr.ioctl(IOCTL_TX_LED,time)
			return ret
		end
	end
end

