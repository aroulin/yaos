LEVEL = ../..

librealmode.a: bios.o a20-gate.o num2string.o mem_size.o
	ar rcs $@ $^

clean:
	rm -rf *.o *.a *~

include $(LEVEL)/Makefile.rules
