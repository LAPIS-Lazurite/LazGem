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
	def get_panid()
		packet = Hash["command"=> 0x0411]
		result = write_driver(packet)
		packet = read()
		begin
			while(packet.fetch("command") != 0x0410) do
				packet = read()
			end
			panid = packet.fetch("rxPanid")
		rescue
			msg = sprintf("fail to get panid...")
			raise msg
		end
		return panid
	end
	def set_panid(panid)
		if(panid <0 ) || (panid > 0xffff) then
			msg = sprintf("invalid panid: 0x0000 - 0xffff.but 0x%04x",panid)
			raise msg
		end
		packet = Hash["command" => 0x0413,"rxPanid" => panid]
		# write to driver
		write_driver(packet)
	end
end

