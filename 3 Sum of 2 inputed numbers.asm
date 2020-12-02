.model small
.stack 100h
.data
.code
	main proc
		
		mov ah, 01h
		int 21h
		mov bl, al
		sub bl, 48

		mov ah, 01h
		int 21h
		mov cl, al
		sub cl, 48

		add bl, cl

		mov dl, bl
		add dl, 48
		mov ah, 02h
		int 21h

		mov ah, 04ch
		int 21h
	main endp
end main
