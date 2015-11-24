GHC ?= ../inplace/bin/ghc-stage2
HCOPTS ?= -g

all : Test1

% : %.hs
	$(GHC) $(HCOPTS) $< -o $@
