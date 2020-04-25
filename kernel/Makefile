ARCH=x86_64
TOOLCHAIN = ../toolchain/build/bin

CC=$(TOOLCHAIN)/$(ARCH)-elf-gcc
CFLAGS=-z max-page-size=0x1000 -O2 -ffreestanding -MMD -mno-red-zone -Wall -Wextra -mcmodel=kernel -fno-pie -std=gnu99

OBJS = kernel.o
DFILES = $(patsubst %.o,%.d,$(OBJS))

all: kernel.o

kernel.o :
	$(CC)  $(CFLAGS) -c kernel.c -o $@

clean:
	rm -rf $(OBJS) $(DFILES)