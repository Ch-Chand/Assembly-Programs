line macro
    mov dl, 0Ah
    mov ah, 02h
    int 21h

    mov dl, 0Dh
    mov ah, 02h
    int 21h
endm

getch macro
	mov ah, 01h
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
	msg db 'Enter a number : ', '$'
	od db 'Number is Odd', '$'
	ev db 'Number is Even','$'
.code
main proc
	mov ax, @data
	mov ds, ax

	putstr msg
	getch
	line

	mov ah, 0
	mov bl, 2

	div bl
	cmp ah, 1
	je odd
	cmp ah, 0
	je even

	odd:
		putstr od
		mov ah, 04ch
		int 21h

	even:
		putstr ev

	mov ah, 04ch
	int 21h
main endp
end
