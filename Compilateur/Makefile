GRM=cparser.y
LEX=cparser.l
BIN=cparser

CC=gcc
CFLAGS=-Wall -g

OBJ=y.tab.o lex.yy.o table_symboles.o main.o 

all: $(BIN)

table_symboles.o: 
	gcc -c table_symboles.c

test_if :
	./cparser < Test/test_if.txt
	
test2 :
	./cparser < Test/test_if_else.txt

test3 :
	./cparser < Test/test_while.txt

test4 : 
	./cparser < Test/test_arith.txt
	python cross_assembleur.py
	python interpreter.py

%.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

y.tab.c: $(GRM)
	yacc -d -t $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(CPPFLAGS) $^ -o $@
	
clean:
	rm $(OBJ) y.tab.c y.tab.h lex.yy.c cparser

test:   all
	./$(BIN) < test.txt
