; dl should be set to the drive by caller
; bx should be set to desired destination by caller
load_disk:
  pusha

  mov si, disk_load_start_message
  call print

  mov ah, 0x02 ; interrupt code

  mov al, 0x01 ; Number of sectors to read
  mov ch, 0x00 ; Track/Cylinder number
  mov cl, 0x02 ; Sector number. Initial bootloader is in sector 1
  mov dh, 0x00 ; Head number

  int 0x13
  jc .error

  popa
  ret

.error:
  mov si, disk_error_message
  call print

  ; TODO: Compare al with expected sectors
  print_hexw ax

  cli
  hlt

disk_load_start_message: db 'Starting stage 2 disk load', 10, 13, 0
disk_error_message: db 'Stage 2 disk load error. ax: ', 0
