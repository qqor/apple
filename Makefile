ARCH=x86_64
TOOLCHAIN = $(PWD)/toolchain/build/bin


CC=$(TOOLCHAIN)/$(ARCH)-elf-gcc
CFLAGS=-z max-page-size=0x1000 -O2  -ffreestanding -nostdinc -nostdlib -g -Wall -Wextra \
              -Werror  -I. -MMD -mno-red-zone -mcmodel=kernel -fno-pie -no-pie -Wl,--build-id=none

QEMU=qemu-system-$(ARCH)
QEMU_FLAGS = -serial stdio -m 1024M -curses

OBJS := arch/$(ARCH)/boot.o
OBJS += kernel/kernel.o

DFILES = $(patsubst %.o,%.d,$(OBJS))
DIR = kernel arch/$(ARCH)
FILE = mios

.PHONY: build_kernel build_arch qemu iso bin clean

build_kernel:
	$(MAKE) -C kernel ARCH=$(ARCH)

build_arch:
	$(MAKE) -C arch/$(ARCH)

bin: build_kernel build_arch
	$(CC) $(CFLAGS) -T arch/$(ARCH)/linker.ld -o $(FILE).bin $(OBJS)

iso: bin
	mkdir -p iso/boot/grub
	cp grub.cfg iso/boot/grub/
	cp $(FILE).bin iso/boot/
	grub-mkrescue -o $(FILE).iso iso

qemu: iso
	$(QEMU) -cdrom $(FILE).iso $(QEMU_FLAGS)

clean:
	for d in $(DIR); \
	do \
		$(MAKE) -C $$d clean; \
	done

	rm -rf $(FILE).bin $(FILE).iso iso

$(OBJS): Makefile
-include $(DFILES)