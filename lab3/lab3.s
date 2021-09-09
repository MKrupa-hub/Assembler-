SYSEXIT32 = 1
SYSCALL32 = 0x80
EXIT_SUCCESS = 0
SYSWRITE = 4
SYSREAD = 3
STDOUT = 1
STDIN = 0

.section .data
    qn1: .ascii "Podaj pierwsza liczbe: "
    qn1_len = . - qn1
    qn2: .ascii "Podaj druga liczbe: "
    qn2_len = . - qn2
    
    result_mes: .ascii "=  "
    result_mes_len = . - result_mes
    new_line: .ascii "\n"
    new_line_len = . - new_line 

    first_len: .space 4
    second_len: .space 4

    n1_len = 100
    n1: .space n1_len
    n2_len = 100
    n2: .space n2_len

    output: .space n1_len

    first: .space n1_len
    second: .space n2_len

    result_len = 200
    result: .space result_len



.section .text

.global _start
_start:


mov $SYSWRITE, %eax 
mov $STDOUT, %ebx   
mov $qn1, %ecx  
mov $qn1_len, %edx 
int $SYSCALL32


mov $SYSREAD, %eax 
mov $STDIN, %ebx  
mov $n1, %ecx   
mov $n1_len, %edx 
int $SYSCALL32


dec %eax 
mov $0, %edx
movl %eax, %ebx
movl $8, %ecx
div %ecx
cmp $0, %eax
jnz empty1
add $1, %eax

empty1:
movl %eax, first_len
movl %ebx, %eax
dec %eax
mov $0, %edi

convert1:

    mov $0, %ecx 
    movb n1(,%eax,1), %cl 
    call to_number1
    dec %eax
    movb n1(,%eax,1), %bl 
    call to_number2
    shl $4, %bl
    add %bl, %cl 
    mov %cl, first(,%edi,1)
    inc %edi
    dec %eax
    cmp $0, %eax
    jge convert1


mov $SYSWRITE, %eax 
mov $STDOUT, %ebx   
mov $qn2, %ecx  
mov $qn2_len, %edx 
int $SYSCALL32


mov $SYSREAD, %eax 
mov $STDIN, %ebx  
mov $n2, %ecx   
mov $n2_len, %edx 
int $SYSCALL32

dec %eax 
mov $0, %edx
movl %eax, %ebx
movl $8, %ecx
div %ecx
cmp $0, %eax
jnz empty2
add $1, %eax

empty2:
movl %eax, second_len
movl %ebx, %eax
dec %eax
mov $0, %edi
mov $0, %ebx
convert2:

    mov $0, %ecx 
    movb n2(,%eax,1), %cl 
    call to_number1
    dec %eax
    movb n2(,%eax,1), %bl
    call to_number2
    shl $4, %bl
    add %bl, %cl 
    mov %cl, second(,%edi,1)
    inc %edi
    dec %eax
    cmp $0, %eax
    jge convert2

    


mov $0, %ecx
mov $0, %ebx
mov $0, %esi


loop1:
mov $0, %ebx
mov %esi, %ecx
    loop2:
        mov first(,%ebx, 4), %eax
        mov second(,%esi,4), %edi
        mul %edi
        add %eax, result(,%ecx,4) 
        inc %ecx
        adc %edx, result(,%ecx,4) 
        inc %ecx
        adc $1, result(,%ecx,4)
        dec %ecx
        inc %ebx
        cmp first_len, %ebx
        jb loop2
    inc %esi
    cmp second_len, %esi
    jl loop1

mov first_len, %eax
mov second_len, %ebx
add %ebx, %eax 
mov $8, %ebx
mul %ebx
mov %eax, %esi 
mov first_len, %eax
mov second_len, %ebx
add %ebx, %eax
mov $4, %ebx
mov $0, %edx
mul %ebx 
sub $1, %eax
mov $0, %ebx
mov $0, %ecx

convert_3:
    movb result(,%eax,1), %cl
    shr $4, %cl
    call to_letter
    mov %cl, output(,%ebx,1)
    movb result(,%eax,1), %cl
    shl $4, %cl
    shr $4, %cl
    call to_letter
    inc %ebx
    mov %cl, output(,%ebx,1)
    inc %ebx
    dec %eax
    cmp $0, %eax
    jge convert_3

jmp end


.type to_letter @function
to_letter:
    cmpb $10, %cl
    jge letter

    addb $48, %cl
    ret
    letter:
        addb $87, %cl
        ret

.type to_number1 @function
to_number1:

    cmpb $97, %cl
    jge letter_s

    cmpb $65, %cl
    jge letter_b

    cmpb $48, %cl
    jge number_1

    ret
    
    letter_s:
        cmpb $122, %cl
        jg exit
        subb $87, %cl
        ret

    letter_b:
        cmpb $90, %cl
        jg exit
        subb $55, %cl
        ret

     number_1:
        cmpb $57, %cl
        jg exit
        subb $48, %cl
        ret       
    


.type to_number2 @function
to_number2:

    cmpb $97, %bl
    jge letter_s2

    cmpb $65, %bl
    jge letter_b2

    cmpb $48, %bl
    jge number_2

    ret

    letter_s2:
        cmpb $122, %bl
        jg exit
        subb $87, %bl
        ret

    letter_b2:
        cmpb $90, %bl
        jg exit
        subb $55, %bl
        ret

     number_2:
        cmpb $57, %bl
        jg exit
        subb $48, %bl
        ret  

exit:
mov $SYSEXIT32, %eax
mov $EXIT_SUCCESS, %ebx
int $SYSCALL32

end:
mov $SYSWRITE, %eax 
mov $STDOUT, %ebx   
mov $result_mes, %ecx
mov $result_mes_len, %edx
int $SYSCALL32

mov $SYSWRITE, %eax 
mov $STDOUT, %ebx   
mov $output, %ecx
mov %esi, %edx
int $SYSCALL32

mov $SYSWRITE, %eax 
mov $STDOUT, %ebx   
mov $new_line_len, %edx
mov $new_line, %ecx
int $SYSCALL32

jmp exit


