#strncpy.s this is an assembly language program that 
#copier the contents of one string to a user provided
#array and returns a pointer to the provided array
#
#
#
#Author: Paul Cardoos
#Date: 11/1/20 9:37PM

	.text
	.globl mystrncpy

mystrncpy: 

	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	movl 16(%ebp), %ecx
	movl $0x00, %edx 
	movl %eax, %edi
	cmpl %edx, %ecx
	je padstring
	jne copy_loop
 		
copy_loop:
 	
	movl (%ebx), %esi
	movl %esi, (%eax) 
	incl %eax
	incl %ebx
	inc %edx
	je check

check: 
		
	cmpl %ecx, %edx
	je padstring
	jne copy_loop

padstring: 
	
	cmpl $10, %edx
	jge leave
	movl $0x00, %esi
	movl %esi, (%eax)
	incl %eax
	incl %edx
	jmp padstring

leave:
	xorl %eax, %eax
	movl %edi, %eax
	movl %ebp, %esp
	popl %ebp
	ret
	.end 
