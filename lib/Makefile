LEVEL = ..

all: librealmode.a libstring.a

lib%.a: FORCE_RUN
	$(MAKE) -C $*
	cp $*/lib$*.a .

FORCE_RUN:

clean:
	$(MAKE) -C realmode clean
	$(MAKE) -C string clean
	rm -rf *.a

include $(LEVEL)/Makefile.rules
