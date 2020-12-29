dosseg
.model small
.stack 100h
.data

 msg1 db "Enter first number : $"
 msg2 db "Enter second number : $"
 msg3 db "Not Equal$"
 msg4 db "Equal$"
 line db 0Ah, 0Dh

.code
 main proc
  mov ax, @data
  mov ds, ax

  mov dx, offset msg1
  mov ah, 09h
  int 21h

  mov ah, 01h
  int 21h
  mov bl, al

  mov dl, line
  mov ah, 02h
  int 21h

  mov dx, offset msg2
  mov ah, 09h
  int 21h
  
  mov ah, 01h
  int 21h
  mov cl, al

  mov dl, line
  mov ah, 02h
  int 21h

  cmp bl, cl
  je Equal

  mov dx, offset msg3
  mov ah, 09h
  int 21h

  mov ah, 04ch
  int 21h

  Equal:
   mov dx, offset msg4
   mov ah, 09h
   int 21h

  mov ah, 04ch
  int 21h
main endp
end
