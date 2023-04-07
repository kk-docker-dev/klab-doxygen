#!/bin/bash

cat <<-BANNER_SCRIPT
print_welcome_banner() {
	cat <<-BANNER

	##############################################################
	#                                                            #
	# Welcome to KLAB's Doxygen documentation server console.    #
	#                                                            #
	# Add your projects to the shared folder to avail at /host   #
	# directory.                                                 #
	#                                                            #
	# Run 'mkdox' command in the project root path to generate   #
	# the Doxygen project documentation.                         #
	#                                                            #
	# Explore the documentation at localhost:9596/<project-name> #
	# in your favorite web browser.                              #
	#                                                            #
	##############################################################

	BANNER
}

print_welcome_banner;
BANNER_SCRIPT
