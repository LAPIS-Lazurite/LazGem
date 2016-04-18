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
class LAZURITE_ERROR < StandardError; end
class LazGem::Device
	##
	# func   : Read the data from the receiving pipe
	# input  : Receive pipe fp
	# return : Receive data
	##

	@@device_rd=nil
	@@device_wr=nil

# LAZURITE.open(ch=36,panid=0xabcd,pwr=20,rate=100),mode=2)
# function
#	open device deriver
# parameter
#	ch:		frequency 24-61. 36 is in default
#	panid:	pan id
#	pwr:		tx power
#	rate:	bit rate  50 or 100
#	pwr:		tx power  1 or 20
#	mode:	must be 2
# return
#	none
	def device_open(args={})
		args={
			ch: 36,
			pwr: 20,
			rate: 100,
			mode: 2,
			panid: 0xabcd
		}.merge(args)
		p args
		@@ch = args[:ch]
		@@pwr = args[:pwr]
		@@rate = args[:rate]
		@@panid = args[:panid]
		mode = args[:mode]

		if(@@ch < 24) || (@@ch > 61) then
			puts "ch is invalid. it must be 24-61"
			raise LAZURITE_ERROR
			return
		end
		if(@@pwr != 1) && (@@pwr != 20) then
			puts "pwr is invalid. it must be 1 or 20"
			raise LAZURITE_ERROR
			return
		end
		if(@@rate != 50) && (@@rate != 100) then
			puts "rate is invalid. it must be 50 or 100"
			raise LAZURITE_ERROR
			return
		end
		cmd = "sudo insmod /home/pi/develop/LazDriver/DRV_802154.ko ch=" +@@ch.to_s+" panid=0x"+@@panid.to_s(16)+ " pwr="+@@pwr.to_s+" rate="+@@rate.to_s + " mode=0x"+mode.to_s(16)
		p cmd
		result = system(cmd)
		bp3596_dev = "/dev/bp3596"
		sleep(0.1)
		result = system("sudo chmod 777 "+bp3596_dev)
#		p result
		sleep(0.1)
		@@device_rd = open(bp3596_dev,"rb")
		@@device_wr = open(bp3596_dev,"wb")
		result = system("tail -n -2 /var/log/messages")
		print("\n")
#		p result
		print("Success to load SubGHz module\n")
	end

# LAZURITE.close()
# function
#	close device deriver
# parameter
#	none
# return
#	none
	def device_close()
		@@device_rd.close
		@@device_wr.close
		@@devie_rd = nil
		@@device_wr = nil
		cmd = "sudo rmmod DRV_802154"
		system(cmd)
		p cmd
	end


# LAZURITE.read()
# function
#	try to read data from SubGHz module
# parameter
#	none
# return
#	-1:			no data
#	Hash[]:		receiving data
#		key
#		"command" => command	it should be fixed to 0x03
#		"Time" => Time class of receiving time
#		"usec" => integer type data of usec for receiving time
#		"rxPanid" => unsigned long type data of panid for receiving
#			if packet does not include panid, data is -1.
#		"rxAddrType" => unsigned char type deta of address type
#				0 = packet no rxAddr
#				1 = rxAddr = 8 bit integer type
#				2 = rxAddr = 16bit include rxAddr
#				3 = rxAddr = 64bit rxAddr String type
#		"rxAddr" => rx address. data type is determined by rxAddrType
#		"txPanid" => long type data of panid for sending
#			if packet does not include panid, data is -1.
#		"txAddrType" => unsigned char type deta of address type
#			same meaning of data as rxAddrType
#		"txAddr" => tx Address. data type is determind by txAddrType
#		"rssi" => RF power, when receiving
#		"payload" => binary stream type of data. need to unpack for using as strings
	def read()
		# Data reception wait (timeout = 100ms)
		ret = select([@@device_rd], nil, nil, 0.1)
		# Reads the size of the received data
		len = @@device_rd.read(2)
		if ((len == "") || (len == nil)) then # read result is empty
			return -1
		end
		size =  len.unpack("S*")[0]
		# The received data is read
		recv_buf = @@device_rd.read(size)
		if ((recv_buf == "") || (recv_buf == nil)) then # read result is empty
			return -1
		end
		return recv_dec(recv_buf,size)
	end

	def recv_dec(raw,size)
		# PANID
		command =		raw[0..1].unpack("S*")[0]
		tv_sec =		raw[2..5].unpack("L*")[0]
		tv_usec =		raw[6..9].unpack("L*")[0]/1000
		t = Time.at(tv_sec,tv_usec)
		area =			raw[10..11].unpack("a2")[0]
		ch =			raw[12..13].unpack("S*")[0]
		rate =			raw[14..15].unpack("S*")[0]
		pwr =			raw[16..17].unpack("S*")[0]
		header =		raw[18..21].unpack("L*")[0]
		rxPanid =		raw[22..25].unpack("L*")[0]
		rxAddrType =	raw[26].unpack("C*")[0]
		frame_type = header & 0x07
		sec_enb = (header >> 3) & 0x0001
		pending = (header >> 4) & 0x0001
		ack_req = (header >> 5) & 0x0001
		seq_comp = (header >> 8) & 0x0001
		ielist = (header >> 9) & 0x0001
		frame_ver = (header >> 12)&0x0003
		if rxAddrType == 0 then
			rxAddr = -1
		else 
			rxAddr = 0
			for i in 27..34 do
				rxAddr = rxAddr * 256 + raw[i].unpack("C*")[0]
			end
		end
		txPanid =		raw[35..38].unpack("L*")[0]
		txAddrType =	raw[39].unpack("C*")[0]

		if txAddrType == 0 then
			txAddr = -1
		else
			txAddr = 0
			for i in 40..47 do
				txAddr = txAddr * 256 + raw[i].unpack("C*")[0]
			end
		end

		rssi =			raw[48].unpack("C*")[0]
		payload =		raw[49..size-1]
		
		out = Hash["Command" => command,
					"Time" => t,
					"usec" => tv_usec,
					"Area" => area,
					"ch" => ch,
					"rate" => rate,
					"pwr" => pwr,
					"frame_type" => frame_type,
					"sec_enb" => sec_enb,
					"pending" => pending,
					"ack_req" => ack_req,
					"seq_comp" => seq_comp,
					"ielist" => ielist,
					"frame_ver" => frame_ver,
					"rxPanid" => rxPanid,
					"rxAddrType" => rxAddrType,
					"rxAddr" => rxAddr,
					"txPanid" => txPanid,
					"txAddrType" => txAddrType,
					"txAddr" => txAddr,
					"rssi" => rssi,
					"payload" => payload,
					]
	end
end

