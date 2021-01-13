getch macro
 mov ah, 01h
 int 21h
endm

.model small
.stack 100h
.data
 pno dw 0
 cno dw 0
.code
main proc
 mov ax, @data
 mov ds, ax


 l1:
  getch
  cmp al, 0Dh
  je EndInput
  sub al, 48 
  mov ah, 0
  mov cno, ax
  mov dx, 0h
  mov ax, pno
  mov bx, 10
  mul bx
  add ax, cno
  mov pno, ax
 jmp l1

 EndInput:
  mov cx, 0
  mov bx, 10
  mov ax, pno

  Reversing:
   mov dx, 0h
   div bx
   push dx
   inc cx
   cmp ax, 0
   je Display
  jmp Reversing

  Display:
   pop dx
   add dx, 48
   mov ah, 02h
   int 21h
  loop Display

 mov ah,4ch
 int 21h
main endp
end