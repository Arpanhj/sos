nasm -f elf32 src/kernel.asm -o build/kasm.o
gcc -m32 -c src/kernel.c src/lib/bestdio.c -O build/kc.o -fno-stack-protector
ld -m elf_i386 -T src/link.ld -o build/kernel build/kasm.o build/kc.o