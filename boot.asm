[bits 16]     ; We are in 16 bits real mode
[org 0x7c00]  ; BIOS places us at this memory address

jmp main

%include 'print.asm'

main:
  mov si, start_boot_message
  call print
  cli
  hlt

start_boot_message: db 'Starting stage 0', 10, 13, 0

; BIOS looks for 0xaa55
; as last two bytes in a 512 byte segment
times 510-($-$$) db 0
dw 0xaa55
