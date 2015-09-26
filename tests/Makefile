TESTS_SRC = $(shell find . -name *_test.cpp)
TESTS_OBJ = $(patsubst %.cpp, %.o, $(TESTS_SRC))
CXXFLAGS = -std=c++11 -I../include -I.

test: $(TESTS_OBJ)

%.o: %.cpp FORCE
	$(eval PREFIX := $(notdir $(patsubst %_test, %, $(basename $*))))
	$(eval LIB_PATH := $(dir $(shell find .. -name $(PREFIX).cpp)))
	$(MAKE) -C $(LIB_PATH)
	$(eval LIB_NAME := $(shell echo "$(LIB_PATH)" | perl -nle '/^.*\/(.+)\/$$/;print "$$1.a";'))
	$(eval LDFLAGS += -L$(LIB_PATH))
	$(eval LDLIBS += $(LIB_PATH)$(LIB_NAME))
	$(CXX) -c $(CXXFLAGS) $*.cpp -o $@

FORCE:

clean:
	rm -rf test $(shell find . -name *.o)
