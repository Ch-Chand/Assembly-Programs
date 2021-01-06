line macro
    mov dl, 0Ah
    mov ah, 02h
    int 21h

    mov dl, 0Dh
    mov ah, 02h
    int 21h
endm

.model small
.stack 100h
.data
	qou db ?
	rem db ?
.code
main proc
	mov ax, @data
	mov ds, ax

	mov ax, 25
	mov dl, 6
	div dl

	mov qou, al
	add qou, 48
	mov rem, ah
	add rem, 48

	mov dl, qou
	mov ah, 02h
	int 21h

	line

	mov dl, rem
	mov ah, 02h
	int 21h

	mov ah, 04ch
	int 21h
main endp
end
