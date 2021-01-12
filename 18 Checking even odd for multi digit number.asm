getch macro
	mov ah, 01h
	int 21h
endm

.model small
.stack 100h
.data
	chr DB 2
 	pno DW 0
	cno DW 0
	e DB " is EVEN$"
	o DB " is ODD$"
.code
main proc
	mov ax, @data
	mov ds, ax

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
			je Display
		jmp Reverse

		Display:
			pop dx
			mov bx, dx
			add dx, 48
			mov ah, 02h
			int 21h
			cmp cx, 0
			je Check
		loop Display

		Check:
			mov ax, bx
			div chr
			cmp ah, 0
			je ev
			cmp ah, 1
			je od

		ev:
			mov dx, offset e
			mov ah, 09h
			int 21h
			mov ah,4ch
			int 21h

		od:
			mov dx, offset o
			mov ah, 09h
			int 21h

	mov ah,4ch
	int 21h
main endp
end