FROM ubuntu:22.04

ENV user cose-451

RUN apt-get update
RUN apt-get -y install gcc gdb gcc-multilib git vim python3-pip gdbserver netcat
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade pwntools

RUN adduser $user

ADD ./src/class1/. /home/$user/class1/
ADD ./src/class2/. /home/$user/class2/
ADD ./src/assignment1/. /home/$user/assignment1
ADD ./src/assignment2/. /home/$user/assignment2
ADD ./src/assignment2/hard_version/. /home/$user/assignment2/hard_version


WORKDIR /home/$user/class1/

RUN gcc -O0 -m32 -fno-stack-protector -mpreferred-stack-boundary=2 -z execstack -no-pie -fno-pic -o stackframe.o stackframe.c
RUN gcc -O0 -m32 -fno-stack-protector -mpreferred-stack-boundary=2 -z execstack -no-pie -fno-pic -o bof.o bof.c

RUN chmod 777 /home/$user/
RUN chmod 777 /home/$user/class1/
RUN chmod 770 /home/$user/class1/*.o
RUN chmod 660 /home/$user/class1/*.c


WORKDIR /home/$user/class2/

RUN gcc -O0 -m32 -fno-stack-protector -mpreferred-stack-boundary=2 -z execstack -no-pie -fno-pic -o memory_disclosure_1.o memory_disclosure_1.c
RUN gcc -O0 -m32 -fno-stack-protector -mpreferred-stack-boundary=2 -z execstack -no-pie -fno-pic -o memory_disclosure_2.o memory_disclosure_2.c
RUN gcc -O0 -m32 -mpreferred-stack-boundary=2 -z execstack -no-pie -fno-pic -o canary.o canary.c
RUN gcc -O0 -m32 -mpreferred-stack-boundary=2 -z execstack -no-pie -fno-pic -o practice.o practice.c

RUN chmod 777 /home/$user/class2/
RUN chmod 770 /home/$user/class2/*.o
RUN chmod 660 /home/$user/class2/*.c
RUN chmod 660 /home/$user/class2/*.py


WORKDIR /home/$user/assignment1/

RUN gcc -O0 -m32 -fno-stack-protector -mpreferred-stack-boundary=2 -z execstack -no-pie -fno-pic -o super_safe.o super_safe.c

RUN chmod 777 /home/$user/assignment1/
RUN chmod 770 /home/$user/assignment1/*.o
RUN chmod 660 /home/$user/assignment1/*.c
RUN chmod 660 /home/$user/assignment1/*.py


WORKDIR /home/$user/assignment2/

RUN gcc -m32 -mpreferred-stack-boundary=2 -z execstack -no-pie -fno-pic -O0 -o HackTheWoo.o HackTheWoo.c

RUN chmod 777 /home/$user/assignment2/
RUN chmod 770 /home/$user/assignment2/*.o
RUN chmod 660 /home/$user/assignment2/*.c
RUN chmod 660 /home/$user/assignment2/*.py


WORKDIR /home/$user/assignment2/hard_version/

RUN gcc -m32 -mpreferred-stack-boundary=2 -z execstack -no-pie -fno-pic -O0 -o HackTheWoo.o HackTheWoo.c

RUN chmod 777 /home/$user/assignment2/hard_version/
RUN chmod 770 /home/$user/assignment2/hard_version/*.o
RUN chmod 660 /home/$user/assignment2/hard_version/*.c
RUN chmod 660 /home/$user/assignment2/hard_version/*.py


RUN chown -R root:$user /home/$user/*

USER $user

RUN git clone https://github.com/longld/peda.git /tmp/peda
RUN echo "source /tmp/peda/peda.py" >> ~/.gdbinit
RUN echo "DONE! debug your program with gdb and enjoy"

WORKDIR /home/$user
