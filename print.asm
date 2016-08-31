[bits 16]

; Expects a 0 terminated string in si
print:
  pusha
  mov ah, 0x0e ; BIOS write char flag

.loop:
  lodsb
  test al, al
  je .end
  int 0x10 ; Write character in al when ah is 0x0e
  jmp .loop

.end:
  popa
  ret
