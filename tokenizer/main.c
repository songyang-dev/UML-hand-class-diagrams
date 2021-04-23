#include <stdio.h>
#include "tree.h"
#include "pretty.h"

void yyparse();
YUML* root;

int main(int argc, char * argv[])
{
	//printf("Enter a \"yUML\" expression followed by Ctrl-d/Ctrl-z:\n");

	yyparse();

    printYUML(root);

	return 0;
}