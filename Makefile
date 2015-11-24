GHC ?= ../inplace/bin/ghc-stage2
HCOPTS ?= -g

all : Test1 FfiTest

FfiTest : ffi-test.c

% : %.hs
	$(GHC) $(HCOPTS) $+ -o $@
