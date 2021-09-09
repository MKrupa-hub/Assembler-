.data
    float: .asciz "%f"
    result: .asciz "%f\n"
    string: .ascii "%s\0"
    n1: .float 0.0
    n2: .float 0.0
    choice: .float

    qadd: .ascii "1. Dodawanie\n\0"
    qsub: .ascii "2. Odejmowanie\n\0"
    qmul: .ascii "3. Mnozenie\n\0"
    qdiv: .ascii "4. Dzielenie\n\0"

    qup: .ascii "1. W gore\n\0"
    qdown: .ascii "2. W dol\n\0"
    qnearest: .ascii "3. Do najblizszej\n\0"
    qzero: .ascii "4. Do zera\n\0"

    qn1: .ascii "Podaj pierwsza liczbe: \0"
    qn2: .ascii "Podaj druga liczbe: \0"

    rup: .short 0x0B3F
    rdown: .short 0x073F
    rnearest: .short 0x033F
    rzero: .short 0x0F3F

.text

.globl main

main:
#pytania o rodzaj operacji

    push %edx
    push %eax
    push $qadd      
    call printf
    add $12, %esp

    push %edx
    push %eax
    push $qsub    
    call printf
    add $12, %esp
    
    push %edx
    push %eax
    push $qmul
    call printf
    add $12, %esp

    push %edx
    push %eax
    push $qdiv   
    call printf
    add $12, %esp

#wczytanie opcji od aktora
    pushl $choice
    push $string
    call scanf
    addl $8, %esp

#pytania o wartosci
    push %edx
    push %eax
    push $qn1   
    call printf
    add $12, %esp

    
#wczytanie wartosci    
    pushl $n1
    push $float
    call scanf
    addl $8, %esp

    push %edx
    push %eax
    push $qn2    
    call printf
    add $12, %esp

    pushl $n2
    push $float
    call scanf
    addl $8, %esp


#wybranie odpowieniej operacji

    cmpb $49, choice
    je add
    # 2
    cmpb $50, choice
    je sub
    # 3
    cmpb $51, choice
    je mul
    # 4
    cmpb $52, choice
    je div

add:
    sub $12, %esp      
    flds n1
    fadds n2
    fstpl (%esp) 
jmp round

sub:
    sub $12, %esp
    flds n1
    fsubs n2
    fstpl (%esp)
jmp round

mul:
    sub $12, %esp
    flds n1
    fmuls n2
    fstpl (%esp)
jmp round

div:
    sub $12, %esp
    flds n1
    fdivs n2
    fstpl (%esp)
jmp round
    
round:
    push %edx
    push %eax
    push $qup      
    call printf
    add $12, %esp

    push %edx
    push %eax
    push $qdown    
    call printf
    add $12, %esp
    
    push %edx
    push %eax
    push $qnearest
    call printf
    add $12, %esp

    push %edx
    push %eax
    push $qzero   
    call printf
    add $12, %esp

    pushl $choice
    push $string
    call scanf
    addl $8, %esp

    cmpb $49, choice
    je up
    cmpb $50, choice
    je down
    cmpb $51, choice
    je nearest
    cmpb $52, choice
    je zero

    up:
    fldcw rup
    jmp continue
    down:
    fldcw rdown
    jmp continue
    nearest:
    fldcw rnearest
    jmp continue
    zero:
    fldcw rzero
    jmp continue

continue:
#edycja wyniku
    movl (%esp), %eax  
    movl 4(%esp), %edx 
    call pr
    addl $12, %esp

    ret

pr:
    push %edx
    push %eax
    push $result
    call printf
    add $12, %esp
    ret
