.global readmsg

.section .data

  num1: .space 100
  num2: .space 8
  bytes: .int 1

  result: .space 300



.section .bss


.section .text

readmsg:
  push %ebp
  mov %esp, %ebp
  push %ebx


  byte:
  mov 8(%ebp), %eax
  mov %eax, bytes
  asd:

  data:
  mov 12(%ebp), %eax
  lea 0(%eax), %ebx


  mov $0, %ecx
  mov $0, %eax
  mov $0, %edx
m:
con:
  skip_bytes:
  inc %ecx
  inc %dh
  cmp bytes, %dh
  jne skip_bytes

  mov $0,%dh
  movb (%ebx, %ecx, 1), %al
hide:
  shr $1, %al
  jna one
  mov $0, %dl
  #mov %dl, result(,%ecx,1)
  cont:
  inc %ecx
  inc %ah
  cmp $8, %ah
  jne con
  


end1:
mov $0, %ecx
#mov $result, %eax
  
  asdsa:
  pop %ebx
  pop %ebp
  ret


one:
  mov $1 , %dl
 #mov %dl, result(,%ecx,1)
  jmp cont

