dosseg
.model small
.stack 100h
.data
 
 array db 5 DUP (?)
 line db 0Ah, 0Dh

.code
 main proc

  mov ax, @data
  mov ds, ax

  mov cx, 5
  mov si, offset array

  Input:
   mov ah, 01h
   int 21h
   mov byte ptr [si], al
   inc si
  loop Input

  mov dl, line
  mov ah, 02h
  int 21h

  mov cx, 5
  mov si, offset array
 
  Output:
   mov dl, [si]
   mov ah, 02h
   int 21h
   inc si
  loop Output

 mov ah,04ch
 int 21h
 main endp
end