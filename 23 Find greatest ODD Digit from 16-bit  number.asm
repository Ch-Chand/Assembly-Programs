; Greatest ODD digit from 16-bit number

;;; MACROS;;;
pushReg macro
	push ax
	push bx
	push cx
	push dx
endm

popReg macro
	pop dx
	pop cx
	pop bx
	pop ax
endm

line macro
	pushReg
	mov dl, 0Ah
	mov ah, 02h
	int 21h

	mov dl, 0Dh
	mov ah, 02h
	int 21h
	popReg
endm

getch macro
	mov ah, 01h
	int 21h
endm

putchr macro chr
	pushReg
	mov dl, chr
	mov ah, 02h
	int 21h
	popReg
endm

putstr macro str
	pushReg
	mov dx, offset str
	mov ah, 09h
	int 21h
	popReg
endm


;;;MAIN PROGRAM;;;
.model small
.stack 100h
.data
	chr DB 0
	chr2 DB 0
	temp DB 0

 	pno DW 0
	cno DW 0
	d DB 2

	msg1 DB " has Greatest ODD digit of  $"
	msg2 DB "No ODD digit in number$"
.code
main proc
	mov ax, @data
	mov ds, ax

	jmp StartInput

	Place:
		mov chr, bl
		cmp bl, chr2
		jg Greatest
	jmp Continue

	Greatest:
		mov chr2, bl
	jmp Continue

	StartInput:
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
	jmp StartInput

	EndInput:
		mov bx, 10
		mov cx, 0
		mov ax, pno

		Reverse:	
			mov dx, 0h
			div bx
			push dx
			inc cx
			cmp ax, 0
			je CheckGreater
		jmp Reverse

		CheckGreater:
			pop bx
			mov ax, bx
			div d
			cmp ah, 0h
			jne Place

			Continue:
				add bx, 48
				putchr bl
				
		loop CheckGreater

		cmp chr2, 0h
		je noOdd

		putstr msg1
		add chr2, 48
		putchr chr2
		mov ah,4ch
		int 21h	

		noOdd:
			line
			putstr msg2

	mov ah,4ch
	int 21h
main endp
end