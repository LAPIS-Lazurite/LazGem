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
# function
#	sending data by SubGHz
#	currently only one format is supported.
# parameter
#	HASH[]
#		currently two parameter should be included.
#		"rxAddr" => 	Integer type of rxAddress
#		"payload" => 	binary array of sending data
#		<option>
#		"rxPanid" => rxPanid. If it is not included, rxPanid = 0xABCD
# return
#		none
# Exception
#		KeyError			: if hash data does not include rxAddr, this error is raisen.
#		PAYLOAD_SIZE_OVER	: payload length is over
	def get_rate()
		packet = Hash["command"=> 0x0405]
		result = write_driver(packet)
		packet = read()
		begin
			rate = packet.fetch("rate")
		rescue
			msg = sprintf("fail to get rate number...")
			raise msg
		end
		return rate
	end
	def set_rate(rate)
		if(rate != 100) && (rate != 50) then
			msg = sprintf("invalid rate, 50 or 100 =%d",rate)
			raise msg
		end
		packet = Hash["command" => 0x0407,"rate" => rate]
		# write to driver
		write_driver(packet)
	end
end

