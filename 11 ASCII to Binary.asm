line macro
    mov dl, 0Ah
    mov ah, 02h
    int 21h

    mov dl, 0Dh
    mov ah, 02h
    int 21h
endm

putch macro chr
	mov dl, chr
	mov ah, 02h
	int 21h
endm

.model small
.stack 100h
.data
	chr db ?
	qou db ?
	rem db ?
.code
    main proc
	mov ax, @data
	mov ds, ax

	mov ax, 19		; Place your number here 
	mov bl, 2
	mov cx, 0
        l1:
		div bl
		add ah, 48
		mov qou, al
		mov rem, ah
		mov al, rem
		mov ah, 0
		push ax

		mov ah, 0
		mov al, qou
		
		inc cx
		cmp ax, 1
		jl Display
        jmp l1

	Display:
		pop chr
		putch chr
	loop Display

        mov ah, 04ch
        int 21h
    main endp
end