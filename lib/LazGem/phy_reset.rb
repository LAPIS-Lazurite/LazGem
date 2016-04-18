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
	def phy_reset()
		command = 0x0101

		raw = [command].pack("S")
		#printf(sprintf("header=%04x\n",header))
		ret = select(nil, [@@device_wr], nil, 0.1)
		begin
			len = @@device_wr.write(raw)
		rescue
			puts "Doesn't receive ACK"
			raise LAZURITE_ERROR
		end
		return len
	end
end

