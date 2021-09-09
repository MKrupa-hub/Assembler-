SYSEXIT32 = 1
SYSCALL32 = 0x80
EXIT_SUCCESS = 0
SYSWRITE = 4
SYSREAD = 3
STDOUT = 1
STDIN = 0
input_len = 100

.global _start

.data
input: .space input_len

.text

_start:
mov $SYSREAD, %eax
mov $STDIN, %ebx
mov $input, %ecx
mov $input_len, %edx
int $SYSCALL32


mov %eax, %r8d
dec %r8d
mov $0, %r9d

loop:
addb $13, input(%r9d)

cmpb $136, input(%r9d)
jae correct4

cmpb $77, input(%r9d)
jb correct4
cmpb $90, input(%r9d)
ja correct2
return:
cmpb $122, input(%r9d)
ja correct3
cmpb $110, input(%r9d)
jb correct1

inc %r9d
cmp %r8d, %r9d
jl loop
jmp exit

correct4:
sub $13, input(%r9d)
jmp done
correct1:
cmpb $91, input(%r9d)
jb done
sub $13, input(%r9d)
jmp done
correct2:
cmpb $103, input(%r9d)
ja return
correct3:
sub $26, input(%r9d)
done:
inc %r9d
cmp %r8d, %r9d
jb loop
exit:


mov $SYSWRITE, %eax
mov $STDOUT, %ebx
mov $input, %ecx
mov $input_len, %edx
int $SYSCALL32

mov $SYSEXIT32, %eax
mov $EXIT_SUCCESS, %ebx
int $SYSCALL32
