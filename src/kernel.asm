;;kernel.asm
bits 32
section .text
    ;multiboot spec
    align 4
    dd 0x1BADB002
    dd 0x00
    dd - (0x1BADB002 + 0x00)

global start
global start
global keyboard_handler
global read_port
global write_port
global load_idt
global sys_reset

extern kmain
extern keyboard_handler_main

start:
    cli
    mov esp, stack_space
    call kmain
    hlt

read_port:
    mov edx, [esp + 4]
    in al, dx
    ret

write_port:
    mov edx, [esp + 4]
    mov al, [esp + 4 + 4]
    out dx, al
    ret

load_idt:
    mov edx, [esp + 4]
    lidt [edx]
    sti 
    ret

keyboard_handler:
    call keyboard_handler_main
    iretd

sys_reset:
    ;Connect to APM API
    MOV     AX, 5301h
    XOR     BX,BX
    INT     15

    ;Try to set APM version (to 1.2)
    MOV     AX, 530Eh
    XOR     BX,BX
    MOV     CX, 0102h
    INT     15

    ;Turn off the system
    MOV     AX, 5307h
    MOV     BX, 0001h
    MOV     CX, 0003h
    INT     15

    ;Exit (for good measure and in case of failure)
    RET

section .bss
resb 8192
stack_space: