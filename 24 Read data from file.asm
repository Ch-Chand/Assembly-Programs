; READ FROM FILE

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
	msg1 DB "Enter File_Name.extension : $"
	filename DB 30 DUP(0)
	filehandler DW 0
	file_content DB 3 DUP("$")
	cont_len DW 0
.code
main proc
	mov ax, @data
	mov ds, ax
	mov es, ax

	putstr msg1
	mov si, offset filename

	l1:
		getch
		cmp al, 0dh
		je EndFilename
		mov byte ptr [si], al
		inc si
	jmp l1
	EndFilename:

	mov dx, offset filename
	mov al, 0
	mov ah, 03dh
	int 21h

	line
	mov filehandler, ax

	l2:
		mov dx, offset file_content
		mov cx, 1
		mov bx, filehandler
		mov ah, 03fh
		int 21h

		cmp ax, 0
		je EndOfFile
		putstr file_content
	jmp l2
	EndOfFile:
	line

	mov bx, filehandler
	mov ah, 3eh
	int 21h

	mov ah, 04ch
	int 21h
main endp
end