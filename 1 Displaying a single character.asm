.model small		;Defines the size of program in memory
.stack 100h		;Size of stack in memory
.data			;Variables and contants will be declared here
.code			;Area where you will write instructions
 main proc		;Procedure start and you can define more then 1 procedure

  mov ax,@data
  mov ds,ax

  mov dl, 'C'		;Intialized Data register with charater 'C'
  mov ah, 02h		;Intializing Acamulator register with the display service.
  int 21h		;Generating interrupt to perform task stored in acamulator reg.
  
  mov ax, 04ch		;Intializing Acamulator register with the exit service (4ch)
  int 21h

 main endp		;Ending main procedure
end			;Ending program

