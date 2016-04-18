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
# Exception
	def get_edval()
		packet = Hash["command"=> 0x0415]
		result = write_driver(packet)
		packet = read()
		begin
			edval = packet.fetch("rssi")
		rescue
			msg = sprintf("fail to get edval...")
			raise msg
		end
		return edval
	end
end

