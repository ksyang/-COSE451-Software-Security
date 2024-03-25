FROM ubuntu:22.04

ENV user cose-451

RUN apt-get update
RUN apt-get -y install socat gcc gdb gcc-multilib git vim python3-pip
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade pwntools

RUN adduser $user

ADD ./examples/. /home/$user/

WORKDIR /home/$user

RUN gcc -O0 -m32 -fno-stack-protector -mpreferred-stack-boundary=2 -z execstack -no-pie -fno-pic -o stackframe.o stackframe.c
RUN gcc -O0 -m32 -fno-stack-protector -mpreferred-stack-boundary=2 -z execstack -no-pie -fno-pic -o bof.o bof.c

RUN chown root:$user /home/$user/*

RUN chmod 755 /home/$user/
RUN chmod 770 /home/$user/*.o
RUN chmod 660 /home/$user/*.c

USER $user

RUN git clone https://github.com/longld/peda.git /tmp/peda
RUN echo "source /tmp/peda/peda.py" >> ~/.gdbinit
RUN echo "DONE! debug your program with gdb and enjoy"

WORKDIR /home/$user
