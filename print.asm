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

; %1 is any word sized register
%macro print_hexw 1
  ; uses ax, cx, and dx
  pusha

  mov dx, %1 ; store data from register param in dx

  mov ah, 0x0e ; set BIOS write char flag
  ; write out a preceeding 0x
  mov al, 0x30
  int 0x10
  mov al, 0x78
  int 0x10

  mov cl, 4 ; We will be writing out 4 bytes
  xor al, al ; Need to clear out al because upper nibble must be 0
  ror dx, 12 ; get register in proper position for loop

%%loop:
  ror dx, 12
  mov al, dl
  shr al, 4 ; first nibble needs to be 0 for magic to work

  ; magic that turns hex in lower nibble into
  ; ascii printable version
  cmp al, 0x0A
  sbb al, 0x69
  das

  int 0x10

  sub cl, 1
  test cl, cl
  jne %%loop

  popa
%endmacro
