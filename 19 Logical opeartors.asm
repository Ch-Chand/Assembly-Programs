getch macro chr
	mov ah, 01h
	int 21h
	mov chr, al
endm

line macro
	mov dl, 0Ah
	mov ah, 02h
	int 21h

	mov dl, 0Dh
	mov ah, 02h
	int 21h
endm

putchr macro chr
	mov dl, chr
	mov ah, 02h
	int 21h
endm

putstr macro str
	mov dx, offset str
	mov ah, 09h
	int 21h
endm

.model small
.stack 100h
.data
	choice DB 0
	n1 DB 0
	n2 DB 0
	msg1 DB "Enter First Number  : $"
	msg2 DB "Enter Second Number : $"
	msg3 DB "1 for AND", 0Ah, 0Dh, "2 for OR", 0Ah, 0Dh, "3 for NOT", 0Ah, 0Dh, "Enter Choice...     : $"
	msg4 DB "Result of AND       : $"
	msg5 DB "Result of OR        : $"
	msg6 DB "Result of NOT       : $"
.code
main proc
	mov ax, @data
	mov ds, ax

	putstr msg1
	getch n1

	line

	putstr msg2
	getch n2

	line

	putstr msg3
	getch choice

	line

	sub choice, 48

	cmp choice, 01h
	je AndOp
	cmp choice, 02h
	je OrOp
	cmp choice, 03h
	je NotOp

	AndOp:
		putstr msg4
		mov al, n1
		mov ah, 0h

		mov bl, n2
		mov bh, 0h

		AND ax, bx

		putchr ax

        	mov ah, 04ch
		int 21h

	OrOp:
		putstr msg5
		mov al, n1
		mov ah, 0h

		mov bl, n2
		mov bh, 0h

		OR ax, bx

		putchr ax

        	mov ah, 04ch
		int 21h

	NotOp:
		putstr msg6
		mov al, n1
		mov ah, 0h

		NOT ax

		putchr ax

        	mov ah, 04ch
		int 21h

	mov ah, 04ch
	int 21h
main endp
end main