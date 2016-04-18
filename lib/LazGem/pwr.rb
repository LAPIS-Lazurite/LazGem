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
	def get_pwr()
		packet = Hash["command"=> 0x0409]
		result = write_driver(packet)
		packet = read()
		begin
			pwr = packet.fetch("pwr")
		rescue
			msg = sprintf("fail to get pwr number...")
			raise msg
		end
		return pwr
	end
	def set_pwr(pwr)
		if(pwr != 1) && (pwr != 20) then
			msg = sprintf("invalid pwr: 1 or 20.but %d",pwr)
			raise msg
		end
		packet = Hash["command" => 0x040B,"pwr" => pwr]
		# write to driver
		write_driver(packet)
	end
end

