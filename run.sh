#!/bin/sh
ecpg program.pgc
gcc -I/usr/include/postgresql -c program.c
gcc -o program program.o -L/usr/lib -lecpg
./program
