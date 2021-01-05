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
.code
    main proc

	mov cx, 5
	mov bx, 1
	l1:
		push cx
		mov cx, bx
		l2:
			mov dl, "*"
			mov ah, 02h
			int 21h
		loop l2
		line
		inc bx
		pop cx
	loop l1

        mov ah, 04ch
        int 21h
    main endp
end