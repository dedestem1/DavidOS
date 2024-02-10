org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

; Note
; mov arg1, arg2 ; then arg2 overwrites arg1


start:
	jmp main

	
;
; Prints a string to the screen
; Params:
; 	- ds:si points to string
;
puts:
	; save registers we will modify
	push si
	push ax


.loop:
	lodsb					; loads next character in al
	or al, al				; verify if next character is null?
	jz .done 

	mov ah, 0x0e
	mov bh, 0
	int 0x10
	
	jmp .loop
.done:
	pop ax
	pop si
	ret



main:

	; setup data segments
	mov ax, 0 		;can't write to ds/es directly
	mov ds, ax
	mov es, ax

	; setup stack
	mov ss, ax
	mov sp, 0x7C00 ; stack grows downwards from where we are loaded in memory

	; print Hello
	mov si, msg_Hello
	call puts

	hlt
	jmp .halt
	
.halt:
	jmp .halt



msg_Hello: db  'Hello!', ENDL, 0


times 510-($-$$) db 0
dw 0AA55h
