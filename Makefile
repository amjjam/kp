# When calling this Makefile you can set the following variables:
#
# prefix is the prefix of the installation directory. Thus the library
# files will be installed in $(prefix)/lib and the include file in
# $(prefix)/include. If prefix is not specified it defaults to ~/
#
# atimeincludedir. To compile requires access to atime.H. This
# variable contains the directory to search for the file. If it is not
# specified it defaults to ~/include
#

ifndef prefix
	prefix=~
endif
export prefix
ifndef atimeincludedir
	atimeincludedir=~/include
endif
export atimeincludedir

build:
	$(MAKE) -C src build
	$(MAKE) -C include build

install:
	$(MAKE) -C src install
	$(MAKE) -C include install

clean:
	$(MAKE) -C src clean
	$(MAKE) -C include clean

uninstall:
	$(MAKE) -C src uninstall
	$(MAKE) -C include uninstall
