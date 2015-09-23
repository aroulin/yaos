
TESTS_SRC = $(shell find . -name *_test.cpp)
TESTS_OBJ = $(patsubst %.cpp, %.o, $(TESTS_SRC))
CXXFLAGS = -I../include -I.

test: $(TESTS_OBJ)

%.o:
	$(eval PREFIX := $(notdir $(patsubst %_test, %, $(basename $*))))
	$(eval LIB_PATH := $(dir $(shell find .. -name $(PREFIX).cpp)))
	$(MAKE) -C $(LIB_PATH)
	$(eval LDFLAGS += -L$(LIB_PATH))
	$(eval LDLIBS += $(LIB_PATH)/$(PREFIX).a)
	$(CXX) -c $(CXXFLAGS) $*.cpp -o $@


clean:
	rm -rf test $(shell find . -name *.o)
