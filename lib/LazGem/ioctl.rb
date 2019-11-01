
# -*- coding: utf-8; mode: ruby -*-
#
# Function:
#   Lazurite Pi Gateway SubGHz library

class LazGem::Device
	IOCTL_CMD=			0x0000
	IOCTL_SET_BEGIN=		IOCTL_CMD+0x11
	IOCTL_SET_RXON=			IOCTL_CMD+0x13
	IOCTL_SET_RXOFF=		IOCTL_CMD+0x15
	IOCTL_SET_CLOSE=		IOCTL_CMD+0x17
	IOCTL_GET_SEND_MODE=	 IOCTL_CMD+0x18
	IOCTL_SET_SEND_MODE=	 IOCTL_CMD+0x19
	IOCTL_SET_AES=           IOCTL_CMD+0x1a
	IOCTL_PARAM=		0x1000
	IOCTL_GET_CH=			IOCTL_PARAM+0x02
	IOCTL_SET_CH=			IOCTL_PARAM+0x03
	IOCTL_GET_PWR=			IOCTL_PARAM+0x04
	IOCTL_SET_PWR=			IOCTL_PARAM+0x05
	IOCTL_GET_BPS=			IOCTL_PARAM+0x06
	IOCTL_SET_BPS=			IOCTL_PARAM+0x07
	IOCTL_GET_MY_PANID=		IOCTL_PARAM+0x08
	IOCTL_SET_MY_PANID=		IOCTL_PARAM+0x09
	IOCTL_GET_DST_PANID=		IOCTL_PARAM+0x0a
	IOCTL_SET_DST_PANID=		IOCTL_PARAM+0x0b
	IOCTL_GET_MY_ADDR0=		IOCTL_PARAM+0x0c
	IOCTL_GET_MY_ADDR1=		IOCTL_PARAM+0x0d
	IOCTL_GET_MY_ADDR2=		IOCTL_PARAM+0x0e
	IOCTL_GET_MY_ADDR3=		IOCTL_PARAM+0x0f
	IOCTL_SET_MY_SHORT_ADDR=IOCTL_PARAM+0x10
	IOCTL_GET_MY_SHORT_ADDR=IOCTL_PARAM+0x11
	IOCTL_GET_DST_ADDR0=	IOCTL_PARAM+0x14
	IOCTL_SET_DST_ADDR0=	IOCTL_PARAM+0x15
	IOCTL_GET_DST_ADDR1=	IOCTL_PARAM+0x16
	IOCTL_SET_DST_ADDR1=	IOCTL_PARAM+0x17
	IOCTL_GET_DST_ADDR2=	IOCTL_PARAM+0x18
	IOCTL_SET_DST_ADDR2=	IOCTL_PARAM+0x19
	IOCTL_GET_DST_ADDR3=	IOCTL_PARAM+0x1a
	IOCTL_SET_DST_ADDR3=	IOCTL_PARAM+0x1b
	IOCTL_GET_ADDR_TYPE=	IOCTL_PARAM+0x1c
	IOCTL_SET_ADDR_TYPE=	IOCTL_PARAM+0x1d
	IOCTL_GET_ADDR_SIZE=	IOCTL_PARAM+0x1e
	IOCTL_SET_ADDR_SIZE=	IOCTL_PARAM+0x1f
	IOCTL_GET_DRV_MODE=		IOCTL_PARAM+0x20
	IOCTL_SET_DRV_MODE=		IOCTL_PARAM+0x21
	IOCTL_GET_SENSE_TIME=	IOCTL_PARAM+0x22
	IOCTL_SET_SENSE_TIME=	IOCTL_PARAM+0x23
	IOCTL_GET_TX_RETRY=		IOCTL_PARAM+0x24
	IOCTL_SET_TX_RETRY=		IOCTL_PARAM+0x25
	IOCTL_GET_TX_INTERVAL=	IOCTL_PARAM+0x26
	IOCTL_SET_TX_INTERVAL=	IOCTL_PARAM+0x27
	IOCTL_GET_CCA_WAIT=		IOCTL_PARAM+0x28
	IOCTL_SET_CCA_WAIT=		IOCTL_PARAM+0x29
	IOCTL_GET_RX_SEC0=		IOCTL_PARAM+0x2A
	IOCTL_GET_RX_SEC1=		IOCTL_PARAM+0x2C
	IOCTL_GET_RX_NSEC0=		IOCTL_PARAM+0x2E
	IOCTL_GET_RX_NSEC1=		IOCTL_PARAM+0x30
	IOCTL_GET_RX_RSSI=		IOCTL_PARAM+0x32
	IOCTL_GET_TX_RSSI=		IOCTL_PARAM+0x34
	IOCTL_SET_PROMISCUOUS=	IOCTL_PARAM+0x35
	IOCTL_SET_ACK_REQ=		IOCTL_PARAM+0x37
	IOCTL_SET_BROADCAST=	IOCTL_PARAM+0x39
	IOCTL_SET_EACK_DATA=	IOCTL_PARAM+0x3B
	IOCTL_SET_EACK_LEN=		IOCTL_PARAM+0x3D
	IOCTL_SET_EACK_ENB=		IOCTL_PARAM+0x3F
	IOCTL_GET_EACK=			IOCTL_PARAM+0x40
	IOCTL_SET_ACK_INTERVAL=	IOCTL_PARAM+0x43
	IOCTL_SET_DSSS_MODE=	IOCTL_PARAM+0x80
	IOCTL_SET_DSSS_SF=	    IOCTL_PARAM+0x81
	IOCTL_SET_DSSS_SIZE=	IOCTL_PARAM+0x82
	IOCTL_RF=			0x2000
	IOCTL_RF_READ=		IOCTL_RF
	IOCTL_RF_WRITE=		IOCTL_RF
	IOCTL_EEPROM=		0x3000
	IOCTL_RX_LED=		0x4000
	IOCTL_TX_LED=		0x4000

###			API
	def begin(ch,panid,bps,pwr)
		set_ch(ch)
		set_my_panid(panid)
		set_bps(bps)
		set_pwr(pwr)
		return set_begin()
	end
	def setMyAddress(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_MY_SHORT_ADDR,addr)
		return ret
	end
	def getMyAddress()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_MY_SHORT_ADDR,addr)
		return ret
	end
	def getMyAddr64()
		data = get_my_addr0();
		addr = data << 48;
		data = get_my_addr1();
		addr = addr | (data << 32);
		data = get_my_addr2();
		addr = addr | (data << 16);
		data = get_my_addr3();
		addr = addr | (data << 0);
		return addr;
	end
	def rxDisable()
		rxon = 0;
		ret = @@device_wr.ioctl(IOCTL_SET_RXOFF,rxon)
		return ret
	end
	def rxEnable()
		rxon = 1
		ret = @@device_wr.ioctl(IOCTL_SET_RXON,rxon)
		return ret
	end
	def setPromiscuous(on)
		ret = @@device_wr.ioctl(IOCTL_SET_PROMISCUOUS,on)
	end
	def setAckReq(on)
		ret = @@device_wr.ioctl(IOCTL_SET_ACK_REQ,on)
	end
	def setBroadcastEnb(on)
		ret = @@device_wr.ioctl(IOCTL_SET_BROADCAST,on)
	end
	def setEnhanceAck(data)
		ret = @@device_wr.ioctl(IOCTL_SET_EACK_ENB,0)
		ret = @@device_wr.ioctl(IOCTL_SET_EACK_LEN,data.length)
		bindata = data.pack("C*")
		ret = @@device_wr.ioctl(IOCTL_SET_EACK_DATA,bindata)
		ret = @@device_wr.ioctl(IOCTL_SET_EACK_ENB,1)
	end
	def getEnhanceAck()
		data = Array.new(32,0)
		bindata = data.pack("C*")
		size = @@device_wr.ioctl(IOCTL_GET_EACK,bindata)
		ret = bindata.unpack("C"+size.to_s)
	end
	def setAckTxInterval(interval)
		size = @@device_wr.ioctl(IOCTL_SET_ACK_INTERVAL,interval)
	end
	def close()
		data = 0
		ret = @@device_wr.ioctl(IOCTL_SET_CLOSE,data)
		return ret
	end
	def getSendMode()
		data = 0
		ret = @@device_wr.ioctl(IOCTL_GET_SEND_MODE,data)
		param = Hash.new()
		param["addr_type"] = get_addr_type()
		param["sense_time"] = get_sense_time()
		param["tx_retry"] = get_tx_retry()
		param["tx_interval"] = get_tx_interval()
		param["cca_wait"] = get_cca_wait()
		param["my_address"] = get_my_addr0()
		return param
	end
	def setSendMode(param)
		ret = @@device_wr.ioctl(IOCTL_GET_SEND_MODE,data)
		begin
			data = param.fetch("addr_type")
			ret = @@device_wr.ioctl(IOCTL_SET_ADDR_TYPE,data)
		rescue Exception
		end
		begin
			data = param.fetch("sense_time")
			ret = @@device_wr.ioctl(IOCTL_SET_SENSE_TIME,data)
		rescue Exception
		end
		begin
			data = param.fetch("tx_retry")
			ret = @@device_wr.ioctl(IOCTL_SET_TX_RETRY,data)
		rescue Exception
		end
		begin
			data = param.fetch("tx_interval")
			ret = @@device_wr.ioctl(IOCTL_SET_TX_INTERVAL,data)
		rescue Exception
		end
		begin
			data = param.fetch("cca_wait")
			ret = @@device_wr.ioctl(IOCTL_SET_CCA_WAIT,data)
		rescue Exception
		end
		begin
			data = param.fetch("my_address")
			ret = @@device_wr.ioctl(IOCTL_SET_MY_ADDRESS,data)
		rescue Exception
		end
		ret = @@device_wr.ioctl(IOCTL_SET_SEND_MODE,data)
		return ret
	end
	def setKey(key)
		ret = @@device_wr.ioctl(IOCTL_SET_AES,key)
		return ret
	end

	def getAddrType()
		ret = @@device_wr.ioctl(IOCTL_GET_SEND_MODE,0)
		return get_addr_type()
	end
	def setAddrType(addr_type)
		ret = @@device_wr.ioctl(IOCTL_GET_SEND_MODE,0)
		ret = set_addr_type(addr_type)
		ret = @@device_wr.ioctl(IOCTL_SET_SEND_MODE,0)
		return ret
	end

	def getTxRetry()
		ret = @@device_wr.ioctl(IOCTL_GET_SEND_MODE,0)
		return get_tx_retry()
	end
	def setTxRetry(cycle)
		ret = @@device_wr.ioctl(IOCTL_GET_SEND_MODE,0)
		ret = set_tx_retry(cycle)
		ret = @@device_wr.ioctl(IOCTL_SET_SEND_MODE,0)
		return ret
	end

###			Libraries
	def set_begin()
		data = 0;
		ret = @@device_wr.ioctl(IOCTL_SET_BEGIN,data)
		return ret
	end
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
	def get_dst_panid()
		panid = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_DST_PANID,panid)
		return ret
	end
	def set_dst_panid(panid)
#		ret = @@device_wr.ioctl(IOCTL_SET_DST_PANID,panid)
#		return ret
        begin
		  @@device_wr.ioctl(IOCTL_SET_DST_PANID,panid)
        rescue Exception => e
          p e
        end
		return 0
	end
	def get_my_addr0()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_MY_ADDR0,addr)
		return ret
	end
	def get_my_addr1()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_MY_ADDR1,addr)
		return ret
	end
	def get_my_addr2()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_MY_ADDR2,addr)
		return ret
	end
	def get_my_addr3()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_MY_ADDR3,addr)
		return ret
	end
	def get_dst_addr0()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_DST_ADDR0,addr)
		return ret
	end
	def set_dst_addr0(addr)
#		ret = @@device_wr.ioctl(IOCTL_SET_DST_ADDR0,addr)
#		return ret
        begin 
		  @@device_wr.ioctl(IOCTL_SET_DST_ADDR0,addr)
        rescue Exception => e
          p e
        end
		return 0
	end
	def get_dst_addr1()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_DST_ADDR1,addr)
		return ret
	end
	def set_dst_addr1(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_DST_ADDR1,addr)
		return ret
	end
	def get_dst_addr2()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_DST_ADDR2,addr)
		return ret
	end
	def set_dst_addr2(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_DST_ADDR2,addr)
		return ret
	end
	def get_dst_addr3()
		addr = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_DST_ADDR3,addr)
		return ret
	end
	def set_dst_addr3(addr)
		ret = @@device_wr.ioctl(IOCTL_SET_DST_ADDR3,addr)
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
	def get_sense_time()
		sense_time = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_SENSE_TIME,sense_time)
		return ret
	end
	def set_sense_time(sense_time)
		ret = @@device_wr.ioctl(IOCTL_SET_SENSE_TIME,sense_time)
		return ret
	end
	def get_tx_retry()
		tx_retry = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_TX_RETRY,tx_retry)
		return ret
	end
	def set_tx_retry(tx_retry)
		ret = @@device_wr.ioctl(IOCTL_SET_TX_RETRY,tx_retry)
		return ret
	end
	def get_tx_interval()
		tx_interval = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_TX_INTERVAL,tx_interval)
		return ret
	end
	def set_tx_interval(tx_interval)
		ret = @@device_wr.ioctl(IOCTL_SET_TX_INTERVAL,tx_interval)
		return ret
	end
	def get_cca_wait()
		cca_wait = 0;
		ret = @@device_wr.ioctl(IOCTL_GET_CCA_WAIT,cca_wait)
		return ret
	end
	def set_cca_wait(cca_wait)
		ret = @@device_wr.ioctl(IOCTL_SET_CCA_WAIT,cca_wait)
		return ret
	end
	def get_rx_time()
		tmp = 0;
		rx_sec = @@device_wr.ioctl(IOCTL_GET_RX_SEC1,tmp)
		rx_sec = rx_sec * 65536 + @@device_wr.ioctl(IOCTL_GET_RX_SEC0,tmp)
		rx_nsec = @@device_wr.ioctl(IOCTL_GET_RX_NSEC1,tmp)
		rx_nsec = rx_nsec *65536 + @@device_wr.ioctl(IOCTL_GET_RX_NSEC0,tmp)
		return rx_sec,rx_nsec
	end
	def get_rx_rssi()
		tmp = 0;
		rssi = @@device_wr.ioctl(IOCTL_GET_RX_RSSI,tmp)
		return rssi
	end
	def get_tx_rssi()
		tmp = 0;
		rssi = @@device_wr.ioctl(IOCTL_GET_TX_RSSI,tmp)
		return rssi
	end


	def setModulation(mode)
		ret = @@device_wr.ioctl(IOCTL_SET_DSSS_MODE,mode)
	end
	def setDsssSpreadFactor(sf)
		ret = @@device_wr.ioctl(IOCTL_SET_DSSS_SF,sf)
	end
	def setDsssSize(size,addrmode)
		size_mode = (size << 8 | addrmode)
		ret = @@device_wr.ioctl(IOCTL_SET_DSSS_SIZE,size_mode)
	end


	def rf_reg_read(addr)
		data = 0;
		if addr >= 0 || addr <= 0xff then
			ret = @@device_wr.ioctl(IOCTL_RF_READ + addr,data)
			return ret
		end
	end
	def rf_reg_write(addr,data)
		if addr >= 0 || addr <= 0xff || data >= 0 || data <= 0xff then
			ret = @@device_wr.ioctl(IOCTL_RF_WRITE + addr + 0x80, data)
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
			ret = @@device_wr.ioctl(IOCTL_RX_LED + 0x0800,time)
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
