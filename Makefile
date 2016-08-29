all: clean boot.bin

.PHONY: run
run:
	qemu-system-i386 boot.bin

.PHONY: clean
clean:
	rm -f boot.bin

boot.bin:
	nasm -f bin boot.asm -o boot.bin
