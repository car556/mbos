stage2:
  mov si, boot_message
  call print

  cli
  hlt

boot_message: db 'Bootloader in stage 2', 10, 13, 0
