GHC ?= ../inplace/bin/ghc-stage2
HCOPTS ?= -g -rtsopts -ddump-asm -ddump-to-file
READELF ?= /opt/exp/elfutils-root/bin/readelf

all : Test1 FfiTest

clean :
	rm -f Test1 FfiTest ffi-test.o *.o

FfiTest : ffi-test.o

ffi-test.o : ffi-test.c
	gcc -ggdb $+ -c -o $@

% : %.hs
	$(GHC) $(HCOPTS) $+ -o $@

%.frames : %
	$(READELF) --debug-dump=frames $< > $@

%.frames-dump : %
	readelf -R.debug_frame $< > $@
