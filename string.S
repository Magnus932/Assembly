
# string lib for 32-bit
       
        # char *strnstr(char *haystack, char *needle, int len);
        strnstr:
                pushl           %ebp
                movl            %esp, %ebp
                pushl           8(%ebp)
                popl            ptr
                subl            $1, ptr
                xor             %ecx, %ecx
                loop:
                        addl            $1, ptr
                        movl            ptr, %eax
                        cmpb            (%eax), %cl                                             # If the byte on current haystack addr is a zero, exit, cuz elsewise this would run forever..
                        je exit_strnstr
                        pushl           16(%ebp)
                        pushl           12(%ebp)
                        pushl           ptr
                        call strncmp
                        addl            $12, %esp
                        cmp             %eax, %ecx
                        je loop
                       
                        # Elseif %eax == 1
                        movl            ptr, %eax
                        movl            %ebp, %esp
                        popl            %ebp
                        ret
                       
                        exit_strnstr:
                                movl            $0, %eax
                                movl            %ebp, %esp
                                popl            %ebp
                                ret
        # End
       
        # int strncmp(char *s1, char *s2, int len);
        strncmp:
                pushl           %ebp
                movl            %esp, %ebp
                movl            12(%ebp), %edi                                          # *s2
                movl            8(%ebp), %esi                                           # *s1
                dec             %esi
                dec             %edi
                xor             %edx, %edx                                                      # len counter
                compare:
                        inc             %edx
                        inc             %esi
                        inc             %edi
                        movb            (%esi), %al
                        movb            (%edi), %bl
                        cmpb            %al, %bl
                        jne rets
                        cmp             %edx, 16(%ebp)
                        jne compare
                        movl            $1, %eax
                        movl            %ebp, %esp
                        popl            %ebp
                        ret
                        rets:
                                movl            $0, %eax
                                movl            %ebp, %esp
                                popl            %ebp
                                ret
        # End
 
        # int strlen(char *s1);
        strlen:
                        pushl           %ebp
                        movl            %esp, %ebp
                        xor             %ecx, %ecx
                        xor             %edx, %edx
                        movl            $-1, %eax
                        movl            8(%ebp), %ebx
                        movb            $0, %dl
                        loop_strlen:
                                inc             %eax
                                inc             %ebx
                                movb            -1(%ebx), %cl
                                cmp             %dl, %cl
                                jne loop_strlen
                                movl            %ebp, %esp
                                popl            %ebp
                                ret
                # End
       
        # char *strcpy(char *src, char *dst, char condition), untill condition met, places a zero after the condition character
                strcpy:
                        pushl           %ebp
                        movl            %esp, %ebp
                        movl            8(%ebp), %eax                           # Source
                        movl            12(%ebp), %ebx                          # Destination
                        dec             %eax
                        dec             %ebx
                        xor             %ecx, %ecx
                        loop2:
                                inc             %eax
                                inc             %ebx
                                movb            (%eax), %cl
                                movb            %cl, (%ebx)
                                cmpb            16(%ebp), %cl
                                jne loop2
                        # Zero out last byte
                        inc             %ebx
                        movb            $0, (%ebx)
                        movl            %ebp, %esp
                        popl            %ebp
                        ret
        # End
       
        # char *strcpy2(char *src, char *dst, char condition), untill condition met, places a zero on the condition character
                strcpy2:
                        pushl           %ebp
                        movl            %esp, %ebp
                        movl            8(%ebp), %eax                           # Source
                        movl            12(%ebp), %ebx                          # Destination
                        dec             %eax
                        dec             %ebx
                        xor             %ecx, %ecx
                        loop22:
                                inc             %eax
                                inc             %ebx
                                movb            (%eax), %cl
                                movb            %cl, (%ebx)
                                cmpb            16(%ebp), %cl
                                jne loop22
                        # Zero out last byte
                        movb            $0, (%ebx)
                        movl            %ebp, %esp
                        popl            %ebp
                        ret
        # End

