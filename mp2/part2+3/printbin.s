#printbin: this assembly language program is a function that asks the user
#for a hex number between 0 and 0xff and converts the input from an ASCII 
#string to a char value, passes to printbinc.c as an arguement and 
#returns a string of binary values
#
#
#
#
#Author: Paul Cardoos
#Date: 11/4/2020 1:58PM
	
	.globl printbin
	.data

string:

	.asciz "0000 0000"
	
	.text
printbin: 

	pushl %ebp
	mov %esp, %ebp
	movl 8(%ebp), %ebx
	movl 8(%ebp), %ecx
	movl $string, %eax
	movl %eax, %esi
	call Donibble
	movl $0x20, (%eax)
	incl %eax #increment eax to account for space
	shl $4, %bl	
	call Donibble
	movl $string, %eax	
	mov %ebp, %esp
	popl %ebp
	ret

Donibble:
	pushl %ebp
	mov %esp, %ebp
	xorl %edx, %edx
	movl $0, %edx
loop:   
	cmpl $4, %edx
	je leave
	shl $1, %cl #shift left 1
	jc copy_1
	jnc copy_0
copy_1:

	movl $0x31,(%eax)
	incl %eax
	incl %edx
	jmp loop

copy_0: 
	movb $0x30,(%eax)
	incl %eax
	incl %edx 
	jmp loop
leave:
	mov %ebp, %esp
	popl %ebp
	ret

.end
