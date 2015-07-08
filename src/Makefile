libdir=$(prefix)/lib

CPPFLAGS=-Wall -g -fPIC -I $(atimeincludedir)
CPP=g++

KP_SRC=kp.C
KP_OBJ=$(KP_SRC:.C=.o)

build: libKp.a libKp.so

libKp.a: $(KP_OBJ)
	ar rc $@ $^

libKp.so: $(KP_OBJ)
	$(CPP) -shared -Wl,-soname,$@ -o $@ $^

install: $(libdir)/libKp.a $(libdir)/libKp.so

$(libdir)/libKp.a $(libdir)/libKp.so: libKp.a libKp.so
	cp libKp.a libKp.so $(libdir)

uninstall:
	- rm -f $(libdir)/libKp.a $(libdir)/libKp.so

clean:
	- rm -f libKp.a libKp.so $(KP_OBJ)
