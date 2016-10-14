[bits 16]     ; We are in 16 bits real mode
[org 0x7c00]  ; BIOS places us at this memory address

jmp main

%include 'print.asm'
%include 'load_disk.asm'

new_line: db 10, 13, 0
boot_drive_message: db 'Loading in from: ', 0
start_boot_message: db 'Entered bootloader', 10, 13, 0
stage_two_message: db 'Stage 2 loaded. Entering stage 2', 10, 13, 0

main:
  mov si, start_boot_message
  call print

  ; BIOS sets boot drive in dl
  mov si, boot_drive_message
  call print
  print_hexb dl
  mov si, new_line
  call print

  ; First memory available after stage 1 section (0x7c00-0x7dff)
  mov bx, 0x7e00
  ; dl should still be set from initial BIOS load
  call load_disk

  mov si, stage_two_message
  call print

  jmp 0x7e00

  cli
  hlt


; BIOS looks for 0xaa55
; as last two bytes in a 512 byte segment
times 510-($-$$) db 0
dw 0xaa55

%include 'stage2.asm'
