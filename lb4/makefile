all: embdsql

%.c: %.ec
	ecpg $<

%.o: %.c
	gcc -g -O0 -Wall -Werror -c -I/usr/include/postgresql $<

embdsql: embdsql.o main.o
	gcc -o $@ $^ -lecpg
