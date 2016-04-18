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
	def get_cca_cycle()
		packet = Hash["command"=> 0x0417]
		result = write_driver(packet)
		packet = read()
		begin
			cca_retry = packet.fetch("rssi")
		rescue
			msg = sprintf("fail to get cca_retry...")
			raise msg
		end
		return cca_retry
	end
	def set_cca_cycle(cca_cycle)
		if(cca_cycle <0 ) || (cca_cycle > 255) then
			msg = sprintf("invalid cca_cycle: 0 - 255. but %d",cca_cycle)
			raise msg
		end
		packet = Hash["command" => 0x0419,"rssi" => cca_cycle]
		# write to driver
		write_driver(packet)
	end
end

