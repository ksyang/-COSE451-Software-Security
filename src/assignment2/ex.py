from pwn import *

context.log_level = 'debug'

r = process('HackTheWoo.o')
# r = remote('221.149.226.120', 31338)
