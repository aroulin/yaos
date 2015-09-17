all: librealmode.a libstring.a

lib%.a:
	$(MAKE) -C $*
	cp $*/lib$*.a .

clean:
	$(MAKE) -C realmode clean
	$(MAKE) -C string clean
	rm -rf *.a