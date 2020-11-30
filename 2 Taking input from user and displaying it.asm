.model small		;Defines the size of program in memory
.stack 100h		;Size of stack in memory
.data			;Variables and contants will be declared here

 msg1 db "Enter First Character : ","$"
 msg2 db " Enter Second Charater : ","$"
 msg3 db " Your inputed characters are : ","$"
 ch1 db ?
 ch2 db ?

.code			;Area where you will write instructions
 main proc		;Procedure start and you can define more then 1 procedure

  mov ax, @data	`	;Intializing data segment
  mov ds,ax

;For first input

  lea dx, msg1		;Intialized Data register with message 1
  mov ah, 09h		;Intializing Acamulator register with the display service.
  int 21h		;Generating interrupt to perform task stored in acamulator reg.
  
  mov ah, 01h		;Intializing Accamulator register to take input
  int 21h
  mov ch1, al		;Storing entered character in variable ch1

;For Second Input

  lea dx, msg2
  mov ah, 09h
  int 21h
  
  mov ah, 01h
  int 21h
  mov ch2, al

;Displaying Inputed data

  lea dx, msg3
  mov ah, 09h
  int 21h

  mov dl, ch1
  mov ah, 02h
  int 21h

  mov dl, ','
  mov ah, 02h
  int 21h

  mov dl, ch2
  mov ah, 02h
  int 21h

  mov ah, 04ch		;Intializing Acamulator register with the exit service (4ch)
  int 21h

 main endp		;Ending main procedure
end			;Ending program

