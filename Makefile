CXXFLAGS := $(shell wx-config  --version=2.8 --unicode=yes --debug=no --cxxflags)
LINKFLAGS := $(shell wx-config  --version=2.8 --unicode=yes --debug=no --libs)
BINARY := xword

SRCS := $(wildcard src/*.cpp) $(wildcard src/*/*.cpp)
HDRS := $(wildcard src/*.hpp) $(wildcard src/*/*.hpp)
OBJS := $(patsubst %.cpp, %.o, $(SRCS)) 

# if V is on the command line (I do V=1), then we'll get verbose output
ifeq ("$(origin V)", "command line")
  Q =
else
  Q = @
endif

%.o: %.cpp $(HDRS)
	@echo "  CC      " $@
	$(Q)g++ -c -o $@ $< $(CXXFLAGS)

$(BINARY): $(OBJS)
	@echo "  LINK    " $@
	$(Q)g++ -o $@ $^ $(LINKFLAGS)

clean:
	$(Q)rm -f $(BINARY) $(OBJS)
