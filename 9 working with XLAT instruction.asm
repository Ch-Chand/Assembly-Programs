dosseg
.model small
.stack 100h
.data
 arr db "ABCDEF"
.code
 main proc
  mov ax, @data
  mov ds, ax

  lea bx, arr
  mov al, 3
  xlatb
  mov dl, al
  mov ah, 02h
  int 21h

  mov ah, 04ch
  int 21h
main endp
end


