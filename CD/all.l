%option noyywrap                                                                                                                                                        
%{                                                                                                                                                                      
#include <stdio.h>                                                                                                                                                      
#include <stdlib.h>                                                                                                                                                     
#include "y.tab.h"                                                                                                                                                      
extern int yylval;                                                                                                                                                      
%}                                                                                                                                                                      
alpha [A-Za-z]                                                                                                                                                          
digit [0-9]                                                                                                                                                             
%%                                                                                                                                                                      
[ \t\n]             ; // Ignore whitespace                                                                                                                              
while               return WHILE;                                                                                                                                       
for                 return FOR;                                                                                                                                         
if                  return IF;                                                                                                                                          
else                return ELSE;                                                                                                                                        
{digit}+            { yylval = atoi(yytext); return NUM; }                                                                                                              
{alpha}({alpha}|{digit})*  { return ID; }                                                                                                                               
"<="                return LE;                                                                                                                                          
">="                return GE;                                                                                                                                          
"=="                return EQ;                                                                                                                                          
"!="                return NE;                                                                                                                                          
"||"                return OR;                                                                                                                                          
"&&"                return AND;                                                                                                                                         
.                   return yytext[0]; // Return single character as token                                                                                               
%%
