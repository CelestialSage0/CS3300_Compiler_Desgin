a.out : y.tab.c lex.yy.c
	g++ -O3 lex.yy.c y.tab.c
	@echo " Run the program as ./a.out <input.txt"
y.tab.c : a1.y
	bison -dy a1.y
lex.yy.c : a1.l y.tab.h
	flex a1.l
clean :
	@rm lex.yy.c y.tab.h y.tab.c a.out
