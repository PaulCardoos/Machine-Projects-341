#In this program we are programming a UART directly in assembyly. This is
#an assembler function that reads and echos characters. Most of the code is
#already written by Professor Ronald Cheung and I will be modifying it.
#
#
#Author: Paul Cardoos
#Date 11/4 Time: 10:11 PM 

	.text
	.globl echo

echo:
	pushl %ebp
	mov %esp, %ebp
	movl 8(%ebp), %dx 
	movb 12(%ebp), %bl     #escape char 
	
	xorl %ecx, %ecx
	movw $0x2fc, %dx       #modem control 
	inb (%dx), %al	       #get current
	orb $0x03, %al         #or on 2 lsbs
	outb %al, (%dx)        #set control 

	movw $0x2fe, %dx       #modem status

loop1: 
	inb (%dx), %al         #get current
	andb $0xb0, %al        #get 3 signals
	xorb $0xb0, %al        #some missing
	jnz loop1
loop2:
	movw $0x2fd, %dx       #line status
	inb (%dx), %al         #get data ready
	andb $0x01, %al	       #look at dr	 
        jz loop2                #if recv data 
	movw $0x2f8, %dx       #i/o data addr
	inb (%dx), %al         #move rx to %al
	movb %al , %cl	       #save it somewhere         
	movw $0x2fd, %dx       #line status

xmit:
	inb (%dx), %al         #get thre
	andb $0x20, %al        #look at three
	jz loop2               #if tx hr empty
	movb %cl, %al          #get data to send 
	movw $0x2f8, %dx       #i/o data addr
	outb %al, (%dx)	       #send it
	cmpb %bl, %cl          #compare 
	je leave  	       	
	jmp loop2              #and loop
 
leave:
	mov %ebp, %esp
	popl %ebp
	ret
.end



