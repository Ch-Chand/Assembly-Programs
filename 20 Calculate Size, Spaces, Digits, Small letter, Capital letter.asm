; Calculate Size, Spaces, Digits, Small letter, Capital letter etc....

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
	msg1 DB "Enter String  : $"
	msg2 DB "Your String   : $"
	msg3 DB "Letters       : $"
	msg4 DB "Spaces	      : $"
	msg5 DB "Digits        : $"
	msg6 DB "Small Letters : $"
	msg7 DB "Capi. Letters : $"
	msg8 DB "OutPut.....$"
	msg9 DB "...Shahzad Abbas (BSCS-18-32)...$"
	msg10 DB ".....Thank You.....$"

	para DB 200 DUP("$")
	ltrs DW 0
	sltr DW 0
	cltr DW 0
	spc  DW 0
	dgt  DW 0
	pno  DW 0
.code
main proc
	mov ax,@data
	mov ds,ax

	putstr msg1
	mov si, offset para
	jmp Input

	incSpace:
		inc spc
		jmp Input

	digit:
		cmp al, 58
		jl incDigit 
		jmp calSmall

	incDigit:
		inc dgt
		jmp Input

	small:
		cmp al, 123
		jl incSmall
		jmp calCapital

	incSmall:
		inc sltr
		jmp Input

	capital:
		cmp al, 91
		jl inccapital
		jmp inputend

	inccapital:
		inc cltr
		jmp Input


	Input:
		getch

		cmp al, 0dh
		je Output

		mov byte ptr [si], al
		inc si

		inc ltrs			; Calculating letters
		
		cmp al, 32			; Calculating Spaces
		je incSpace

		cmp al, 47			; Calculating Digit
		jg digit

		calSmall:
		
		cmp al, 96
		jg small

		calCapital:

		cmp al, 64
		jg capital

		inputend:

	jmp Input

	Output:
		line

		putstr msg8
		line

		putstr msg2
		putstr para
		line

		putstr msg3
		mov bx, ltrs
		mov pno, bx
		call print
		line

		putstr msg4
		mov bx, spc
		mov pno, bx
		call print
		line

		putstr msg5
		mov bx, dgt
		mov pno, bx
		call print
		line

		putstr msg6
		mov bx, sltr
		mov pno, bx
		call print
		line

		putstr msg7
		mov bx, cltr
		mov pno, bx
		call print

		line
		line
		putstr msg9

		line
		line
		putstr msg10


	mov ah, 04ch
	int 21h
main endp

;;;PROCEDURES;;;
print proc
	pushReg
	mov ax, pno
	mov bx, 10
	mov cx, 0

	divAgain:
		mov dx, 0h
		div bx
		inc cx
		push dx
		cmp ax, 0
    		jne divAgain
	
	printNum:
    		pop dx
    		add dx,48
    		mov ah,02h
    		int 21h
    	loop printNum
	popReg
ret
print endp

end main
