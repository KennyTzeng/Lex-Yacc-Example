%{
#include "e.tab.h"
int counter = 0;
%}
number        [1-9][0-9]*
leftPar       ("(")
rightPar      (")")
leftBracket   ("[")
rightBracket  ("]")
comma         ,
add           ("+")
sub           ("-")
multi         ("*")
transpose     "^"T
space         (" ")
eol           ("\n")
tab           ("\t")
%%
{number}        { counter++; yylval.ival=atoi(yytext); return(inumber); }
{leftBracket}   { counter++; return(leftB); }
{rightBracket}  { counter++; return(rightB); }
{leftPar}       { counter++; return(leftPar); }
{rightPar}      { counter++; return(rightPar); }
{comma}         { counter++; return(comma); }
{add}           { counter++; yylval.ival=counter; return(addExp); }
{sub}           { counter++; yylval.ival=counter; return(subExp); }
{multi}         { counter++; yylval.ival=counter; return(multiExp); }
{transpose}     { counter+=2; return(transExp); }
{eol}           { return(0); }
{space}         { counter++; }
{tab}           ;
.               ;
%%