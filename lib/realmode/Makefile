LEVEL = ../..

librealmode.a: bios.o a20-gate.o
	ar rcs $@ $^

clean:
	rm -rf *.o *.a

include $(LEVEL)/Makefile.rules
