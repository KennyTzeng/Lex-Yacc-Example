#! bin/bash
bison -d -o e.tab.c e.y
gcc -c -g -I.. e.tab.c
flex -o e.yy.c e.l
gcc -c -g -I.. e.yy.c
gcc -o e e.tab.o e.yy.o -ll