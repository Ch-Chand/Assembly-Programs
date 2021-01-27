dosseg
.model small
.stack 100h
.data
 arr db 20 DUP("$")
.code
 main proc
  mov ax, @data
  mov ds, ax

  mov si, offset arr

  Input:
   mov ah, 01h
   int 21h
   cmp al, 0Dh
   je Display
   mov [si], al;
   inc si
  jmp Input

  Display:
   lea bx, arr
   mov al, 4
   xlatb
   mov dl, al
   mov ah, 02h
   int 21h

  mov ah, 04ch
  int 21h
main endp
end


