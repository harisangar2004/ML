%option noyywrap                                                                                                                                                        
%{                                                                                                                                                                      
#include "y.tab.h"                                                                                                                                                      
%}                                                                                                                                                                      
%%                                                                                                                                                                      
switch          return SWITCH;                                                                                                                                          
case            return CASE;                                                                                                                                            
default         return DEFAULT;                                                                                                                                         
break           return BREAK;                                                                                                                                           
\"[^\"]*\"      { yylval.str = strdup(yytext); return STRING; }  // String literals                                                                                     
\'[^\']\'       { yylval.ch = yytext[1]; return CHAR; }          // Character literals                                                                                  
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return IDENTIFIER; } // Identifiers                                                                               
[0-9]+          { yylval.num = atoi(yytext); return NUMBER; }    // Integer number                                                                                      
":"             return COLON;                                                                                                                                           
"{"             return LBRACE;                                                                                                                                          
"}"             return RBRACE;                                                                                                                                          
";"             return SEMICOLON;                                                                                                                                       
[ \t\n]         ;    // Ignore whitespace                                                                                                                               
.               return yytext[0]; // Return any other character (operators, etc.)                                                                                       
%%                           
