CXX=g++
BAMTOOLS_ROOT=$BAMTOOLS
CXXFLAGS=-O3 -I$(BAMTOOLS_ROOT)/include/bamtools -L$(BAMTOOLS_ROOT)/lib

all: bamaddrg

# builds bamtools static lib, and copies into root
#libbamtools.a:
#	cd $(BAMTOOLS_ROOT) && mkdir -p build && cd build && cmake .. && make
#	cp bamtools/lib/libbamtools.a ./

# statically compiles bamaddrg against bamtools static lib
bamaddrg: bamaddrg.cpp
	$(CXX) $(CXXFLAGS) bamaddrg.cpp -o bamaddrg -lbamtools -lz

clean:
	rm -f bamaddrg *.o

.PHONY: clean
