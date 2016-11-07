## saturn

Command line project for developing HDL code for Numato Lab's Saturn development
board.

## FAQ

### What is saturn?

saturn is a command line project that allows development and flashing of HDL
code. No GUI is necessary to develop hardware code using this project. This
project also contains support for flashing using numato-loader:

http://github.com/amilkovich/numato-loader

### What license is saturn release under?

This project is in the public domain.

### How do you use saturn?

First you need to build the project, install ISE before proceeding. If you're
having issues there is some configuration in Makefile for directories:

	$ git clone https://github.com/amilkovich/saturn.git
	$ cd saturn
	$ make flash
