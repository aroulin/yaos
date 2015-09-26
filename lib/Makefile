LEVEL = ..

all: librealmode.a libstring.a

lib%.a:
	$(MAKE) -C $*

clean:
	$(MAKE) -C realmode clean
	$(MAKE) -C string clean
	$(MAKE) -C io clean
	$(MAKE) -C x64 clean
	rm -rf *.a

include $(LEVEL)/Makefile.rules
