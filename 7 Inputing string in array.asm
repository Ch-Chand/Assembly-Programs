dosseg
.model small
.stack 100h
.data
 
 array db 30 DUP ("$")
 line db 0Ah, 0Dh

.code
 main proc

  mov ax, @data
  mov ds,ax

  mov si, offset array

  Input:
   mov ah, 01h
   int 21h
   cmp al, 0Dh
   je Output
   mov byte ptr [si], al
   inc si
  jmp Input

  mov dl, line
  mov ah, 02h
  int 21h
 
  Output:
   mov dx, offset array
   mov ah, 09h
   int 21h

 mov ah,04ch
 int 21h
 main endp
end