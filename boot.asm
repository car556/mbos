[bits 16]     ; We are in 16 bits real mode
[org 0x7c00]  ; BIOS places us at this memory address

jmp $

; BIOS looks for 0x55 and 0xaa
; as last two bytes in a 512 byte segment
times 510-($-$$) db 0
dw 0xaa55
