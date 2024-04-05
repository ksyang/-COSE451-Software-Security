from pwn import *

context.log_level = 'debug'

r = process('HackTheWoo.o')
