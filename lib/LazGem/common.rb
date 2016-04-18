# -*- coding: utf-8; mode: ruby -*-
#
# Function:
#   Lazurite Pi Gateway SubGHz library

#################################################################
######
######	Do not forget to change path of libraries
######			require and insmod
######
################################################################
class LazGem::Device
	def gen_panid_comp( rxAddrType, txAddrType, rxPanid, txPanid)
		if(rxAddrType.abs==0)&&((txAddrType).abs==0)&&(rxPanid<-1)&&(txPanid<-1) then
			panid_comp = 0
			addr_type = 0
		elsif(rxAddrType.abs==0)&&((txAddrType).abs==0)&&(rxPanid<-1)&&(txPanid>=-1) then
			puts "Address format type error::1"
			raise LAZURITE_ERROR
		elsif(rxAddrType.abs==0)&&((txAddrType).abs==0)&&(rxPanid>=-1)&&(txPanid<-1) then
			panid_comp = 1
			addr_type = 1
		elsif(rxAddrType.abs==0)&&((txAddrType).abs==0)&&(rxPanid>=-1)&&(txPanid>=-1) then
			puts "Address format type error::3"
			raise LAZURITE_ERROR
		elsif(rxAddrType.abs==0)&&((txAddrType).abs>0)&&(rxPanid<-1)&&(txPanid<-1) then
			panid_comp = 1
			addr_type = 3
		elsif(rxAddrType.abs==0)&&((txAddrType).abs>0)&&(rxPanid<-1)&&(txPanid>=-1) then
			panid_comp = 0
			addr_type = 2
		elsif(rxAddrType.abs==0)&&((txAddrType).abs>0)&&(rxPanid>=-1)&&(txPanid<-1) then
			puts "Address format type error::6"
			raise LAZURITE_ERROR
		elsif(rxAddrType.abs==0)&&((txAddrType).abs>0)&&(rxPanid>=-1)&&(txPanid>=-1) then
			puts "Address format type error::7"
			raise LAZURITE_ERROR
		elsif(rxAddrType.abs>0)&&((txAddrType).abs==0)&&(rxPanid<-1)&&(txPanid<-1) then
			panid_comp = 1
			addr_type = 5
		elsif(rxAddrType.abs>0)&&((txAddrType).abs==0)&&(rxPanid<-1)&&(txPanid>=-1) then
			puts "Address format type error::9"
			raise LAZURITE_ERROR
		elsif(rxAddrType.abs>0)&&((txAddrType).abs==0)&&(rxPanid>=-1)&&(txPanid<-1) then
			panid_comp = 0
			addr_type = 4
		elsif(rxAddrType.abs>0)&&((txAddrType).abs==0)&&(rxPanid>=-1)&&(txPanid>=-1) then
			puts "Address format type error::11"
			raise LAZURITE_ERROR
		elsif(rxAddrType.abs>0)&&((txAddrType).abs>0)&&(rxPanid<-1)&&(txPanid<-1) then
			panid_comp = 1
			addr_type = 7
		elsif(rxAddrType.abs>0)&&((txAddrType).abs>0)&&(rxPanid<-1)&&(txPanid>=-1) then
			puts "Address format type error::13"
			raise LAZURITE_ERROR
		elsif(rxAddrType.abs>0)&&((txAddrType).abs>0)&&(rxPanid>=-1)&&(txPanid<-1) then
			addr_type = 6
			panid_comp = 0
		else
		#elsif(rxAddrType.abs>0)&&((txAddrType).abs>0)&&(rxPanid>=-1)(txPanid>=-1) then
			puts "Address format type error::15"
			raise LAZURITE_ERROR
		end
		return panid_comp
	end
	
	def write_driver(packet)
		# command
		begin
			command =packet.fetch("command")
		rescue KeyError
			puts "command error!!"
			raise LAZURITE_ERROR
		end

		#Time
		time = 0
		usec = 0

		#rssi
		begin
			rssi =packet.fetch("rssi")
		rescue KeyError
			rssi = 0
		end

		#area
		begin
			area =packet.fetch("Area")
		rescue KeyError
			area = "jp"
		end

		#rate
		begin
			rate =packet.fetch("rate")
			if(rate != 50) then
				rate = 100
			end
		rescue KeyError
			rate = @@rate
		end

		#ch
		begin
			ch =packet.fetch("ch")
			if((ch < 24) || (ch > 60)) && (rate == 100) then
				puts "channel is invalid(ch = 24-60 w/o 32 at 100kbps) "
				raise LAZURITE_ERROR
			elsif(ch == 32) && (rate == 100) then
				puts "channel is invalid(ch=32, rate=100 is invalid)"
				raise LAZURITE_ERROR
			elsif((ch<24) || (ch > 61)) && (rate == 50) then
				puts "channel must be in 24-61, at 50kbps)"
				raise LAZURITE_ERROR
			end
		rescue KeyError
			ch = @@ch
		end

		#pwr
		begin
			pwr =packet.fetch("pwr")
			if(pwr != 1) then
				packet["pwr"] = 20
			end
		rescue KeyError
			pwr = @@pwr
		end

		# frame_type
		begin
			frame_type = packet.fetch("frame_type")
			if(frame_type < 0) || (frame_type > 5) then
				puts "frame_type must be 0 to 5"
				raise LAZURITE_ERROR
			end
		rescue KeyError
			frame_type = 1
		end

		# sec_enb
		begin
			sec_enb = packet.fetch("sec_enb")
			if(sec_enb < 0) || (sec_enb > 1) then
				puts "sec_enb must be 0 or 1."
				raise LAZURITE_ERROR
			end
		rescue KeyError
			sec_enb = 0
		end
		# pending
		begin
			pending = packet.fetch("pending")
			if(pending < 0) || (pending > 1) then
				puts "pending must be 0 or 1."
				raise LAZURITE_ERROR
			end
		rescue KeyError
			pending = 0
		end
		# ack_req
		begin
			ack_req = packet.fetch("ack_req")
			if(ack_req < 0) || (ack_req > 1) then
				puts "ack_req must be 0 or 1."
				raise LAZURITE_ERROR
			end
		rescue KeyError
			ack_req = 1
		end
		# seq_comp
		begin
			seq_comp = packet.fetch("seq_comp")
			if(seq_comp < 0) || (seq_comp > 1) then
				puts "seq_comp must be 0 or 1."
				raise LAZURITE_ERROR
			end
		rescue KeyError
			seq_comp = 0
		end
		# ielist
		begin
			ielist = packet.fetch("ielist")
			if(ielist < 0) || (ielist > 1) then
				puts "ielist must be 0 or 1."
				raise LAZURITE_ERROR
			end
		rescue KeyError
			ielist = 0
		end
		# frame_ver
		begin
			frame_ver= packet.fetch("frame_ver")
			if(frame_ver < 0) || (frame_ver > 2) then
				puts "frame_ver must be 0 to 2."
				raise LAZURITE_ERROR
			end
		rescue KeyError
			frame_ver = 2
		end
		# rxPanid
		begin
			rxPanid =packet.fetch("rxPanid")
		rescue KeyError
			rxPanid = -1
		end
		# rxAddrType.abs
		begin
			rxAddrType =packet.fetch("rxAddrType")
			if rxAddrType.abs() > 3 then
				puts "rxAddrType error"
				raise LAZURITE_ERROR
			end
		rescue KeyError
			rxAddrType = -2
		end
		# rxAddr
		begin
			tmp =packet.fetch("rxAddr")
			rxAddr = 0
			for i in 0..7 do
				rxAddr = rxAddr * 256
				rxAddr = rxAddr + ((tmp >> (i*8)) & 0xff)
			end
		rescue KeyError
			rxAddr = -1
		end
		# txPanid
		begin
			txPanid =packet.fetch("txPanid")
		rescue KeyError
			txPanid = -2
		end
		# txAddrType
		begin
			txAddrType =packet.fetch("txAddrType")
			if txAddrType.abs() > 3 then
				puts "txAddrType must be 0 to 2."
				raise LAZURITE_ERROR
			end
		rescue KeyError
			txAddrType = -2
		end

		# txAddr
		begin
			tmp =packet.fetch("txAddr")
			txAddr = 0
			for i in 0..7 do
				txAddr = txAddr * 256
				txAddr = txAddr + ((tmp >> (i*8)) & 0xff)
			end
			txAddrType = txAddrType.abs()
		rescue KeyError
			txAddr = -1
		end

		#payload
		begin
			payload =packet.fetch("payload")
			if payload.length > 235 then
				puts "Payload size over. maximum length is less than 235"
				raise LAZURITE_ERROR
			end
		rescue KeyError
			payload = ""
		end

		# header
		p rxPanid
		panid_comp = gen_panid_comp(rxAddrType,txAddrType,rxPanid,txPanid)
		
		header = ((rxAddrType.abs)<<14) |
				(frame_ver<<12) |
				((txAddrType.abs)<<10) |
				(ielist<<9) |
				(seq_comp<<8) |
				(panid_comp<<6)|
				(ack_req<<5)|
				(pending<<4)|
				(sec_enb<<3)|
				(frame_type)
		raw = [command,
				time,
				usec,
				area,
				ch,
				rate,
				pwr,
				header,
				rxPanid,
				rxAddrType,
				rxAddr,
				txPanid,
				txAddrType,
				txAddr,
				rssi,
				payload].pack("SLLa2SSSLLCQLCQCa*")
#		dump(raw)
		ret = select(nil, [@@device_wr], nil, 0.1)
		begin
			len = @@device_wr.write(raw)
		rescue => e
			raise e
		end
		return len
	end
	def dump(data)
		for num in 0..data.length-1 do
			print(data[num].unpack("H*")[0]," ")
			if(num % 16 == 15) then
				print("\n")
			elsif(num % 16 == 7) then
				print(" ")
			end
    	end
		print("\n")
	end
end

