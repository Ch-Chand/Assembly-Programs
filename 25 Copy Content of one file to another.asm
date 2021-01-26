; Copy Data from  one file to another

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
	msg1 DB "Enter Source File_Name.extension      : $"
	msg2 DB "Enter Destination File_Name.extension : $"
	msg3 DB "File Copied Succesfully$"

	sour_filename DB 30 DUP(0)
	dest_filename DB 30 DUP(0)

	sour_filehandler DW 0
	dest_filehandler DW 0

	file_content DB 2 DUP("$")
	cont_len DW 0
.code
main proc
	mov ax, @data
	mov ds, ax
	mov es, ax

; Taking Source Filename
	putstr msg1
	mov si, offset sour_filename

	l1:
		getch
		cmp al, 0dh
		je EndSourFilename
		mov byte ptr [si], al
		inc si
	jmp l1
	EndSourFilename:

; Taking Destination Filename
	putstr msg2
	mov si, offset dest_filename

	l2:
		getch
		cmp al, 0dh
		je EndDestFilename
		mov byte ptr [si], al
		inc si
	jmp l2
	EndDestFilename:

; Creating Destination File
	mov dx, offset dest_filename
	mov cx, 0h
	mov ah, 03ch
	int 21h

	mov dest_filehandler, ax

; Opening Source File
	mov dx, offset sour_filename
	mov al, 0
	mov ah, 03dh
	int 21h

	mov sour_filehandler, ax

; Copying data from one file to another
	l3:

	; Reading charater from source file
		mov dx, offset file_content
		mov cx, 1
		mov bx, sour_filehandler
		mov ah, 03fh
		int 21h

		cmp ax, 0
		je EndOfSourFile

	; Moving control to the end of Destination file
		mov dx, 0h
		mov cx, 0h
		mov bx, dest_filehandler
		mov al, 2
		mov ah, 42h
		int 21h

	; Writing to Destination file
		mov dx, offset file_content
		mov cx, 1
		mov bx, dest_filehandler
		mov ah, 40H
		int 21h

	jmp l3
	EndOfSourFile:

; Closing both files
	mov bx, sour_filehandler
	mov ah, 3eh
	int 21h

	mov bx, dest_filehandler
	mov ah, 3eh
	int 21h

; Displaying success message
	line
	putstr msg3
	
	
	mov ah, 04ch
	int 21h
main endp
end