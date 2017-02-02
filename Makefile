export LD_LIBRARY_PATH=/opt/exp/elfutils-root/lib/elfutils
HC ?= ../inplace/bin/ghc-stage2
HCOPTS ?= -g -rtsopts
HCOPTS += -ddump-asm -ddump-to-file -ddump-simpl -ddump-stg -ddump-cmm -fforce-recomp -dppr-debug -ddump-cmm-from-stg -ddump-cmm-verbose
READELF ?= /opt/exp/elfutils-root/bin/eu-readelf

all : Test1 FfiTest Test1.dumps

clean :
	rm -f Test1 FfiTest ffi-test.o *.o

FfiTest : ffi-test.o

ffi-test.o : ffi-test.c
	gcc -ggdb $+ -c -o $@

% : %.hs
	$(HC) $(HCOPTS) $+ -o $@

%.dumps : %.frames %.frames-dump %.frames-interp

%.frames : %
	$(READELF) --debug-dump=frames $< > $@

%.frames-interp : %
	readelf --debug-dump=frames-interp $< > $@

%.frames-dump : %
	readelf -x .debug_frame $< > $@

%.asm : %
	objdump -d $< > $@
