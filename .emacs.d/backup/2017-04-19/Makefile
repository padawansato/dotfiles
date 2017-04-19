# href/Makefile

prefix		= /usr/local
bindir		= $(prefix)/bin
EXEEXT		= 
HMAKE           = $(HC) --make $(HCFLAGS) -cpp $(CPPFLAGS) $(PACKAGES)
HC		= stack ghc
HCFLAGS		= -W -fno-warn-unused-matches
CPPFLAGS        = -DPOSIX
PACKAGES	= -package network

TARGETS		= $(href) $(mkhref)
TESTS		= $(testPathUtils) $(testUtils)
href		= href$(EXEEXT)
mkhref		= mkhref$(EXEEXT)
testPathUtils	= test/test_PathUtils$(EXEEXT)
testUtils	= test/test_Utils$(EXEEXT)

all: build-href build-mkhref

build-href:
	$(HMAKE) href.hs -o $(href)

build-mkhref:
	$(HMAKE) mkhref.hs -o $(mkhref)

test: build-testPathUtils build-testUtils
	./$(testPathUtils)
	./$(testUtils)

build-testPathUtils:
	$(HMAKE) -package HUnit test/test_PathUtils.hs -o $(testPathUtils)

build-testUtils:
	$(HMAKE) -package HUnit test/test_Utils.hs -o $(testUtils)

clean:
	rm -f $(TARGETS) core* *.o *.hi $(TESTS) test/*.o test/*.hi

install: all
	mkdir -p $(bindir)
	cp $(TARGETS) $(bindir)

win32:
	$(MAKE) all CPPFLAGS=-DWIN32 EXEEXT=.exe PACKAGES="-package network -package win32"

win32-makedb: win32
	rm -rf db tmp
	mkdir tmp
	for i in ref/Prelude ref/*.*; do todos $$i > tmp/`basename $$i`; done
	(cd tmp; unset HREF_DATADIR; ../mkhref Prelude *.*)
	rm -rf tmp
