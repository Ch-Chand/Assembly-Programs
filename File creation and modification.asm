; Take File name and Data and store it in file...

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
	
	msg1 DB "Enter File_Name.Extension  : $"
	msg2 DB "Enter Paragraph            : $"
	msg3 DB "Paragraph writed into file.$"

	filename DB 20 DUP(0)
	filehandler DW 0

	para DB 100 DUP(?)
	paraLen DW 0

.code
main proc
	mov ax, @data
	mov ds, ax
	mov es, ax

; Inputing File Name
	putstr msg1
	mov si, offset filename
	l1:
		getch
		cmp al, 0dh
		je EndFileName
		mov byte ptr [si], al
		inc si
	jmp l1
	EndFileName:

; Creating File
	mov dx, offset filename
	mov cx, 0h
	mov ah, 03CH
	int 21h

	mov filehandler, ax

; Inputing Paragrapgh
	putstr msg2
	mov si, offset para
	l2:
		getch
		cmp al, 0dh
		je EndPara
		mov byte ptr [si], al
		inc paraLen
		inc si
	jmp l2
	EndPara:

; Writing data into file
	mov dx, offset para
	mov cx, paraLen
	mov bx, filehandler
	mov ah, 40H
	int 21h


	EndProg:
	mov ah, 04ch
	int 21h
	line
	putstr msg3
main endp
end