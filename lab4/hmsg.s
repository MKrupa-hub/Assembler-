.global hidemsg

.section .data

  bytes: .int 1


.section .bss


.section .text

hidemsg:
  push %ebp
  mov %esp, %ebp
  push %ebx
  

  byte:
  mov 8(%ebp), %eax
  mov %eax, bytes

 mov $0,%eax
  mov $0,%al

msg:
mov $0, %dl
  movb 12(%ebp), %dl



 mov $0,%eax


  data:
  mov 16(%ebp), %eax
  lea 0(%eax), %ebx

  mov $0, %ecx
  mov $0, %eax


con:
  skip_bytes:
  inc %ecx
  inc %dh
  cmp bytes, %dh
  jne skip_bytes
  mov $0,%dh
  movb (%ebx, %ecx, 1), %al
  
hide:
 
  and $254, %al
  shl $1, %dl
  jna addone
  cont:
  mov %al, (%ebx,%ecx,1)
  inc %ecx
  inc %ah
  cmp $8, %ah
  jne con
  


end1:

  pop %ebx
  pop %ebp
  ret


addone:
  addb $1, %al
  jmp cont

