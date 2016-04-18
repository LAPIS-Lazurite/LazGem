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
	def get_retry()
		packet = Hash["command"=> 0x041B]
		result = write_driver(packet)
		packet = read()
		begin
			txRetry = packet.fetch("rssi")
		rescue
			msg = sprintf("fail to get retry...")
			raise msg
		end
		return txRetry
	end
	def set_retry(txRetry)
		if(txRetry <0 ) || (txRetry > 0xff) then
			msg = sprintf("invalid retry: 0 - 255.but %d",txRetry)
			raise msg
		end
		packet = Hash["command" => 0x041D,"rssi" => txRetry]
		# write to driver
		write_driver(packet)
	end
end

