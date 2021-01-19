; Just accept aplabets, digits not alloowed

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
	msg1 DB "Enter String without Digits    : $"
	msg2 DB "Digit not Allowed Enter again  : $"
	msg3 DB "..........", 0Ah, 0Dh, "Your final string  : $"
	chr DB ?
	para DB 200 DUP("$")
	
.code
main proc
	mov ax,@data
	mov ds,ax

	mov si, offset para

	putstr msg1
	jmp Input

	check:
		cmp chr, 47
		jg digit
		jmp notdigit

	digit:
		line
		putstr msg2
		putstr para
		jmp Input
	
	Input:
		getch
        	mov cl, al
		mov chr, al
		cmp chr, 0dh
		je Output
 
		cmp chr, 58
		jl check

		notdigit:
			mov byte ptr [si], cl
			inc si
	jmp Input

	Output:
		line
		putstr msg3
		putstr para

	mov ah, 04ch
	int 21h
main endp
end main
