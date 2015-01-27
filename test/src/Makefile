FLAGS=-Wall -g -I ../../../atime/include/
CFLAGS=$(FLAGS)
CPPFLAGS=$(FLAGS)

CC=gcc
CPP=g++

VPATH=../../../atime/src/

TEST1_SRC=test1.C ../../src/kp.C aTime.C
TEST1_OBJ=$(TEST1_SRC:.C=.o)

test1: $(TEST1_OBJ)
	$(CPP) -o $@ $^ -lrt
clean: 
	- rm $(TEST1_OBJ) test1
