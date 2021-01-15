#countc.s this program returns the occurences of a given string in a program
#
#
#
#Author: Paul Cardoos:
#Date: 10/22/20 10:58PM

	.text
	.globl count

count:

	pushl %ebp         		#set up base pointer on stack
	movl  %esp, %ebp		#save a copy of esp in ebp
	movl  8(%ebp), %edx   		#move addrs of str in edx
	movl  12(%ebp), %ebx		#get character into ebx low
	movl  $0, %eax			#initalize count to 0 in eax
  	movl  (%edx), %ecx 		#get first character of string in c
	cmpb   $0x00,%cl
      	je    leave			#check if cl is '\0'
	cmpl   %edx,%ebx
      	je    inc_c			#if equal incr eax register +1
	jne   incstr			#if not equal incr string

incstr:
	
	cmpb  $0x00, (%edx)		#see if null char
	je  leave			#if null char leave prog
	incl %edx			#else incr the string 1 byte 
	cmpb (%edx),%bl		        #compare ecx low to char
	je   inc_c	
	jne  incstr

inc_c:

	inc %eax			#if char matches increment the coun
	jmp incstr

leave:
	movl %ebp, %esp			#normal assembly exit procedures
	popl %ebp
	ret
	.end



	
