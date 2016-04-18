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
	def rxon()
		packet = Hash["command" => 0x040D]
		# write to driver
		write_driver(packet)
	end
	def rxoff()
		packet = Hash["command" => 0x040F]
		# write to driver
		write_driver(packet)
	end
end

