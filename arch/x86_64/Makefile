ARCH=x86_64
TOOLCHAIN = ../../toolchain/build/bin

CC=$(TOOLCHAIN)/$(ARCH)-elf-gcc

OBJS = boot.o
DFILES = $(patsubst %.o,%.d,$(OBJS))


SHARED_FLAGS = -O2 -ffreestanding -nostdinc -nostdlib -g -Wall -Wextra \
              -Werror  -I./include -MMD -mno-red-zone -mcmodel=kernel -fno-pie
CFLAGS = $(SHARED_FLAGS)
ASFLAGS = $(SHARED_FLAGS) -Wa,--divide

all: boot.o

boot.o: boot.S
	$(CC) $(ASFLAGS) -c boot.S -o $@

clean:
	rm -rf $(DFILES) $(OBJS)