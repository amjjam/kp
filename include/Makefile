includedir=$(prefix)/include

build:

install: $(includedir)/kp.H

$(includedir)/kp.H: kp.H
	cp kp.H $(includedir)

uninstall:
	- rm -f $(includedir)/kp.H

clean:
