# given correct installation of flex and bison with its dev libs
all: lex.yy.c parser.tab.c

lex.yy.c: parser.tab.h
	flex yuml.l

parser.tab.c parser.tab.h:
	bison -v --yacc --defines=parser.tab.c --output=parser.tab.h yuml.y
	
clean:    
	rm parser.tab.* lex.yy.c