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
	def get_ch()
		packet = Hash["command"=> 0x0401]
		result = write_driver(packet)
		packet = read()
		begin
			while(packet.fetch("command") != 0x0400) do
				packet = read()
			end
			ch = packet.fetch("ch")
		rescue
			msg = sprintf("fail to get ch number...")
			raise msg
		end
	end
	def set_ch(ch)
		packet = Hash["command" => 0x0403,"ch" => ch]
		if(ch<24) || (ch>61) then
			msg = sprintf("invalid ch number =%d",ch)
			raise msg
		end
		# write to driver
		write_driver(packet)
	end
end

