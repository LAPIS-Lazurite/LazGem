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
	##
	# func   : Read the data from the receiving pipe
	# input  : Receive pipe fp
	# return : Receive data
	##

	@@device_rd=nil
	@@device_wr=nil

	def init(module_test=0x0000)
#		cmd = "sudo insmod /home/pi/driver/LazDriver/lazdriver.ko module_test="+module_test.to_s
		cmd = "sudo modprobe lazdriver module_test="+module_test.to_s
		p cmd
		result = system(cmd)
		lzgw_dev = "/dev/lzgw"
		sleep(0.1)
		result = system("sudo chmod 777 "+lzgw_dev)
#		p result
		sleep(0.1)
		@@device_rd = open(lzgw_dev,"rb")
		@@device_wr = open(lzgw_dev,"wb")
		@@device_wr.sync = true
		@@device_rd.sync = true
		result = system("tail -n -4 /var/log/messages")
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
	def remove()
		begin
			@@device_rd.close
		rescue Exception => e
			p e
		end
		begin
		@@device_wr.close
		rescue Exception => e
			p e
		end
		@@devie_rd = nil
		@@device_wr = nil
		cmd = "sudo rmmod lazdriver"
#		cmd = "sudo modprobe -r lazdriver"
		system(cmd)
		p cmd
	end

	def available()
		size = 2
		len = @@device_rd.read(size)
    	if ((len == "") || (len == nil)) then # read result is empty
      		return 0
		end
    	size =  len.unpack("S*")[0]
		return size
	end

	def readBin()
		size = 2
		len = @@device_rd.read(size)
    	if ((len == "") || (len == nil)) then # read result is empty
      		return 0
    	end
    	size =  len.unpack("S*")[0]

    	# The received data is read
    	raw = @@device_rd.read(size)
    	if ((raw == "") || (raw == nil)) then # read result is empty
      		return -1
		end
		
		len = raw.length
		header = raw.unpack("S*")[0]

		dst_addr_type = (header>>14) & 0x03
		frame_ver = (header >> 12) & 0x03
		src_addr_type = (header >> 10) & 0x03
		ielist = (header >> 9) & 0x01
		seq_comp = (header >> 8) & 0x01
		panid_comp = (header >> 6) & 0x01
		ack_req = (header >> 5) & 0x01
		pending = (header >> 4) & 0x01
		sec_enb = (header >> 3) & 0x01
		frame_type = (header >> 0) & 0x07

		offset = 2

		if seq_comp == 0 then
			seq_num = raw[offset..offset+1].unpack("C")[0]
			offset = offset + 1
		end

		if dst_addr_type == 0 && src_addr_type == 0 && panid_comp == 0 then
			addr_type = 0
			dst_panid = nil
			src_panid = nil
		elsif dst_addr_type == 0 && src_addr_type == 0 && panid_comp != 0 then
			addr_type = 1
			dst_panid = raw[offset..offset+2].unpack("S*")[0]
			offset = offset + 2
			dst_panid = nil
		elsif dst_addr_type == 0 && src_addr_type != 0 && panid_comp == 0 then
			addr_type = 2
			dst_panid = nil
			src_panid = raw[offset..offset+2].unpack("S*")[0]
			offset = offset + 2
		elsif dst_addr_type == 0 && src_addr_type != 0 && panid_comp != 0 then
			addr_type = 3
			dst_panid = nil
			src_panid = nil
		elsif dst_addr_type != 0 && src_addr_type == 0 && panid_comp == 0 then
			addr_type = 4
			dst_panid = raw[offset..offset+2].unpack("S*")[0]
			offset = offset + 2
			src_panid = nil
		elsif dst_addr_type != 0 && src_addr_type == 0 && panid_comp != 0 then
			addr_type = 5
			dst_panid = nil
			src_panid = nil
		elsif dst_addr_type != 0 && src_addr_type != 0 && panid_comp == 0 then
			addr_type = 6
			dst_panid = raw[offset..offset+2].unpack("S*")[0]
			offset = offset + 2
			src_panid = nil
		elsif dst_addr_type != 0 && src_addr_type != 0 && panid_comp != 0 then
			addr_type = 7
			dst_panid = nil
			src_panid = nil
		end

		if dst_addr_type == 0 then
			dst_addr = nil
		elsif dst_addr_type == 1 then
			dst_addr = raw[offset].unpack("C")[0]
			offset = offset+1
		elsif dst_addr_type == 2 then
			dst_addr = raw[offset..offset+1].unpack("S*")[0]
			offset = offset+2
		else
			dst_addr = raw[offset+7].unpack("H2")[0] +
				raw[offset+6].unpack("H2")[0] +
				raw[offset+5].unpack("H2")[0] +
				raw[offset+4].unpack("H2")[0] +
				raw[offset+3].unpack("H2")[0] +
				raw[offset+2].unpack("H2")[0] +
				raw[offset+1].unpack("H2")[0] +
				raw[offset+0].unpack("H2")[0]
			offset = offset+8
		end

		if src_addr_type == 0 then
			src_addr = nil
		elsif src_addr_type == 1 then
			src_addr = raw[offset].unpack("C")[0]
			offset = offset+1
		elsif src_addr_type == 2 then
			src_addr = raw[offset..offset+1].unpack("S")[0]
			offset = offset+2
		else
			src_addr = raw[offset+7].unpack("H2")[0] +
				raw[offset+6].unpack("H2")[0] +
				raw[offset+5].unpack("H2")[0] +
				raw[offset+4].unpack("H2")[0] +
				raw[offset+3].unpack("H2")[0] +
				raw[offset+2].unpack("H2")[0] +
				raw[offset+1].unpack("H2")[0] +
				raw[offset+0].unpack("H2")[0]
			offset = offset+8
		end

		payload = raw[offset..len-1]

		rcv = Hash.new()

		rcv["header"] = header
		rcv["dst_addr_type"] = dst_addr_type
		rcv["frame_ver"] = frame_ver
		rcv["src_addr_type"] = src_addr_type
		rcv["ielist"] = ielist
		rcv["seq_comp"] = seq_comp
		rcv["panid_comp"] = panid_comp
		rcv["ack_req"] = ack_req
		rcv["pending"] = pending
		rcv["sec_enb"] = sec_enb
		rcv["frame_type"] = frame_type
		rcv["addr_type"] = addr_type
		rcv["dst_panid"] = dst_panid
		rcv["src_panid"] = src_panid
		rcv["dst_addr"] = dst_addr
		rcv["src_addr"] = src_addr
		rcv["seq_num"] = seq_num
		rcv["payload"] = payload
		sec,nsec = get_rx_time()
		rcv["sec"]=sec
		rcv["nsec"]=nsec
		rcv["rssi"]=get_rx_rssi()
		return rcv
	end

	def read()
		size = 2
		len = @@device_rd.read(size)
    	if ((len == "") || (len == nil)) then # read result is empty
      		return 0
    	end
    	size =  len.unpack("S*")[0]

    	# The received data is read
    	raw = @@device_rd.read(size)
    	if ((raw == "") || (raw == nil)) then # read result is empty
      		return -1
		end
		
		len = raw.length
		header = raw.unpack("S*")[0]

		dst_addr_type = (header>>14) & 0x03
		frame_ver = (header >> 12) & 0x03
		src_addr_type = (header >> 10) & 0x03
		ielist = (header >> 9) & 0x01
		seq_comp = (header >> 8) & 0x01
		panid_comp = (header >> 6) & 0x01
		ack_req = (header >> 5) & 0x01
		pending = (header >> 4) & 0x01
		sec_enb = (header >> 3) & 0x01
		frame_type = (header >> 0) & 0x07

		offset = 2

		if seq_comp == 0 then
			seq_num = raw[offset..offset+1].unpack("C")[0]
			offset = offset + 1
		end

		if dst_addr_type == 0 && src_addr_type == 0 && panid_comp == 0 then
			addr_type = 0
			dst_panid = nil
			src_panid = nil
		elsif dst_addr_type == 0 && src_addr_type == 0 && panid_comp != 0 then
			addr_type = 1
			dst_panid = raw[offset..offset+2].unpack("S*")[0]
			offset = offset + 2
			dst_panid = nil
		elsif dst_addr_type == 0 && src_addr_type != 0 && panid_comp == 0 then
			addr_type = 2
			dst_panid = nil
			src_panid = raw[offset..offset+2].unpack("S*")[0]
			offset = offset + 2
		elsif dst_addr_type == 0 && src_addr_type != 0 && panid_comp != 0 then
			addr_type = 3
			dst_panid = nil
			src_panid = nil
		elsif dst_addr_type != 0 && src_addr_type == 0 && panid_comp == 0 then
			addr_type = 4
			dst_panid = raw[offset..offset+2].unpack("S*")[0]
			offset = offset + 2
			src_panid = nil
		elsif dst_addr_type != 0 && src_addr_type == 0 && panid_comp != 0 then
			addr_type = 5
			dst_panid = nil
			src_panid = nil
		elsif dst_addr_type != 0 && src_addr_type != 0 && panid_comp == 0 then
			addr_type = 6
			dst_panid = raw[offset..offset+2].unpack("S*")[0]
			offset = offset + 2
			src_panid = nil
		elsif dst_addr_type != 0 && src_addr_type != 0 && panid_comp != 0 then
			addr_type = 7
			dst_panid = nil
			src_panid = nil
		end

		if dst_addr_type == 0 then
			dst_addr = nil
		elsif dst_addr_type == 1 then
			dst_addr = raw[offset].unpack("C")[0]
			offset = offset+1
		elsif dst_addr_type == 2 then
			dst_addr = raw[offset..offset+1].unpack("S*")[0]
			offset = offset+2
		else
			dst_addr = raw[offset+7].unpack("H2")[0] +
				raw[offset+6].unpack("H2")[0] +
				raw[offset+5].unpack("H2")[0] +
				raw[offset+4].unpack("H2")[0] +
				raw[offset+3].unpack("H2")[0] +
				raw[offset+2].unpack("H2")[0] +
				raw[offset+1].unpack("H2")[0] +
				raw[offset+0].unpack("H2")[0]
			offset = offset+8
		end

		if src_addr_type == 0 then
			src_addr = nil
		elsif src_addr_type == 1 then
			src_addr = raw[offset].unpack("C")[0]
			offset = offset+1
		elsif src_addr_type == 2 then
			src_addr = raw[offset..offset+1].unpack("S")[0]
			offset = offset+2
		else
			src_addr = raw[offset+7].unpack("H2")[0] +
				raw[offset+6].unpack("H2")[0] +
				raw[offset+5].unpack("H2")[0] +
				raw[offset+4].unpack("H2")[0] +
				raw[offset+3].unpack("H2")[0] +
				raw[offset+2].unpack("H2")[0] +
				raw[offset+1].unpack("H2")[0] +
				raw[offset+0].unpack("H2")[0]
			offset = offset+8
		end

		payload = raw[offset..len-1]

		rcv = Hash.new()

		rcv["header"] = header
		rcv["dst_addr_type"] = dst_addr_type
		rcv["frame_ver"] = frame_ver
		rcv["src_addr_type"] = src_addr_type
		rcv["ielist"] = ielist
		rcv["seq_comp"] = seq_comp
		rcv["panid_comp"] = panid_comp
		rcv["ack_req"] = ack_req
		rcv["pending"] = pending
		rcv["sec_enb"] = sec_enb
		rcv["frame_type"] = frame_type
		rcv["addr_type"] = addr_type
		rcv["dst_panid"] = dst_panid
		rcv["src_panid"] = src_panid
		rcv["dst_addr"] = dst_addr
		rcv["src_addr"] = src_addr
		rcv["seq_num"] = seq_num
		rcv["payload"] = payload
		sec,nsec = get_rx_time()
		rcv["sec"]=sec
		rcv["nsec"]=nsec
		rcv["rssi"]=get_rx_rssi()
		return rcv
	end
	def send64(addr,payload)
		set_dst_addr0((addr >>  0)&0x000000000000ffff)
		set_dst_addr1((addr >> 16)&0x000000000000ffff)
		set_dst_addr2((addr >> 32)&0x000000000000ffff)
		set_dst_addr3((addr >> 48)&0x000000000000ffff)
		@@device_wr.write(payload)
		sleep 0.001
	end
	def send(panid,addr,payload)
		set_dst_panid(panid)
		set_dst_addr0(addr)
        begin
		  @@device_wr.write(payload)
        rescue Exception => e
          p e
        end
		sleep 0.001
	end
end
