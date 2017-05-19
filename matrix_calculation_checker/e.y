%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void yyerror(const char *message);
int errorCol = 0;
%}
%union {
int  ival;
char ichar;
struct Matrix{
        int leftVal;
        int rightVal;
} matrix;
}
%token <ival> inumber addExp subExp multiExp
%token <ichar> leftB rightB leftPar rightPar comma transExp
%type <matrix> expr
%left addExp subExp
%left multiExp
%left transExp
%left leftPar rightPar
%%
ss      : expr                                { printf("Accepted"); }
        ;

expr    : expr addExp expr      {
									if($1.leftVal==$3.leftVal && $1.rightVal==$3.rightVal){
										$$.leftVal=$1.leftVal;
										$$.rightVal=$1.rightVal;
									}else{
										errorCol=$2;
										yyerror("");
									} 
								}
        | expr subExp expr      {
									if($1.leftVal==$3.leftVal && $1.rightVal==$3.rightVal){
										$$.leftVal=$1.leftVal;
										$$.rightVal=$1.rightVal;
									}else{
										errorCol=$2;
										yyerror("");
									}
								}
        | expr multiExp expr    {
									if($1.rightVal==$3.leftVal){
										$$.leftVal=$1.leftVal;
										$$.rightVal=$3.rightVal;
									}else{
										errorCol=$2;
										yyerror("");
									}
								}
        | expr transExp         {
									$$.leftVal=$1.rightVal;
									$$.rightVal=$1.leftVal;
								}
        | leftB inumber comma inumber rightB    { 
													$$.leftVal=$2;
													$$.rightVal=$4;
												}
        | leftPar expr rightPar     { $$=$2; }
        ;
%%
void yyerror (const char *message)
{
        printf("Semantic error on col %d\n", errorCol);
        exit(0);
}

int main(int argc, char *argv[]) {
        yyparse();
        return(0);
}