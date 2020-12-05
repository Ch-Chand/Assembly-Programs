.model small
.stack 100h
.data

 line db 0Ah,0Dh

.code
 main proc

  mov ax, @data
  mov ds, ax

  mov cx, 10
  mov bl, 48

  Disp:
   mov dl, line
   mov ah, 02h
   int 21h

   mov dl, bl
   mov ah, 02h
   int 21h   

   inc bl
  loop Disp

  mov ah, 04ch
  int 21h

main endp
end