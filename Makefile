EXECUTABLE_NAME=CUDAK2NN
CC=g++-4.9
NVCC=nvcc
ARCH=sm_30
INC=-I/usr/local/cuda/include/
NVCCFLAGS=-Wall -Wextra -Werror -Wshadow -Ofast -mavx2 -mfma
CFLAGS=-Wall -Wextra -Werror -pedantic -Wshadow -Ofast -std=gnu++14 -mavx2 -fomit-frame-pointer -mavx2 -mfma -flto
CCLIBS=
LDFLAGS=-Wall -Wextra -Werror -pedantic -Wshadow -Ofast -std=gnu++14 -mavx2 -fomit-frame-pointer -mavx2 -mfma -flto
LIBS=-L/usr/local/cuda/lib64 -lcudart -lpthread
CPPSOURCES=$(wildcard *.cpp)
CUSOURCES=$(wildcard *.cu)

OBJECTS=$(CPPSOURCES:.cpp=.o) $(CUSOURCES:.cu=.o)

all: $(CPPSOURCES) $(CUSOURCES) $(EXECUTABLE_NAME)

$(EXECUTABLE_NAME) : $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@ $(LIBS)

%.o:%.cpp
	$(CC) -c $(INC) $(CFLAGS) $< -o $@

%.o:%.cu
	$(NVCC) --use_fast_math -arch=$(ARCH) -O3 -ccbin $(CC) -std=c++11 -c $(INC) -Xcompiler "$(NVCCFLAGS)" $< -o $@

clean:
	rm -rf *.o $(EXECUTABLE_NAME)
