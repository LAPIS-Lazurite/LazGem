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

	def device_open()
		cmd = "sudo insmod /home/pi/develop/LazDriver/lazdriver.ko"
		p cmd
		result = system(cmd)
		lzgw_dev = "/dev/lzgw"
		sleep(0.1)
		result = system("sudo chmod 777 "+lzgw_dev)
#		p result
		sleep(0.1)
		@@device_rd = open(lzgw_dev,"rb")
		@@device_wr = open(lzgw_dev,"wb")
		result = system("tail -n -2 /var/log/messages")
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
	def device_close()
		@@device_rd.close
		@@device_wr.close
		@@devie_rd = nil
		@@device_wr = nil
		cmd = "sudo rmmod lazdriver"
		system(cmd)
		p cmd
	end
end
