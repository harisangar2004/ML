%{                                                                                                                                                                      
                                                                                                                                                                        
#include "y.tab.h"                                                                                                                                                      
                                                                                                                                                                        
%}                                                                                                                                                                      
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
%%                                                                                                                                                                      
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
[0-9]+  { yylval.num = atoi(yytext); return NUMBER; }  // Convert the string to an integer                                                                              
                                                                                                                                                                        
"+"     { return PLUS; }                                                                                                                                                
                                                                                                                                                                        
"-"     { return MINUS; }                                                                                                                                               
                                                                                                                                                                        
"*"     { return TIMES; }                                                                                                                                               
                                                                                                                                                                        
"/"     { return DIVIDE; }                                                                                                                                              
                                                                                                                                                                        
\n      { return '\n'; }                                                                                                                                                
                                                                                                                                                                        
[ \t]   { /* skip whitespaces */ }                                                                                                                                      
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
%%                                                                                                                                                                      
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
int yywrap() {                                                                                                                                                          
                                                                                                                                                                        
    return 1;                                                                                                                                                           
                                                                                                                                                                        
}                                                                                                                                                                       
[s2022103554@sflinuxonline 10.10.2024-00:52:12 - /w9]$ cat postfix_eval.y                                                                                               
%{                                                                                                                                                                      
                                                                                                                                                                        
#include <stdio.h>                                                                                                                                                      
                                                                                                                                                                        
#include <stdlib.h>                                                                                                                                                     
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
void yyerror(const char *s);                                                                                                                                            
                                                                                                                                                                        
int yylex();                                                                                                                                                            
                                                                                                                                                                        
%}                                                                                                                                                                      
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
%union {                                                                                                                                                                
                                                                                                                                                                        
    int num;  // Use int for storing numbers                                                                                                                            
                                                                                                                                                                        
}                                                                                                                                                                       
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
%token <num> NUMBER                                                                                                                                                     
                                                                                                                                                                        
%token PLUS MINUS TIMES DIVIDE                                                                                                                                          
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
%type <num> expr  // Declare that expr will store integer values                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
%%                                                                                                                                                                      
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
input:                                                                                                                                                                  
                                                                                                                                                                        
    /* empty */                                                                                                                                                         
                                                                                                                                                                        
    | input line                                                                                                                                                        
                                                                                                                                                                        
;                                                                                                                                                                       
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
line:                                                                                                                                                                   
                                                                                                                                                                        
    expr '\n' { printf("Result: %d\n", $1); }                                                                                                                           
                                                                                                                                                                        
;                                                                                                                                                                       
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
expr:                                                                                                                                                                   
                                                                                                                                                                        
    NUMBER { $$ = $1; }  // Push number onto the stack                                                                                                                  
                                                                                                                                                                        
    | expr expr PLUS { $$ = $1 + $2; }  // Pop two numbers, perform addition, and push result                                                                           
                                                                                                                                                                        
    | expr expr MINUS { $$ = $1 - $2; }  // Pop two numbers, perform subtraction, and push result                                                                       
                                                                                                                                                                        
    | expr expr TIMES { $$ = $1 * $2; }  // Pop two numbers, perform multiplication, and push result                                                                    
                                                                                                                                                                        
    | expr expr DIVIDE {                                                                                                                                                
                                                                                                                                                                        
        if ($2 == 0) {                                                                                                                                                  
                                                                                                                                                                        
            yyerror("Division by zero");                                                                                                                                
                                                                                                                                                                        
            YYABORT;                                                                                                                                                    
                                                                                                                                                                        
        }                                                                                                                                                               
                                                                                                                                                                        
        $$ = $1 / $2;  // Pop two numbers, perform division, and push result                                                                                            
                                                                                                                                                                        
    }                                                                                                                                                                   
                                                                                                                                                                        
;                                                                                                                                                                       
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
%%                                                                                                                                                                      
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
void yyerror(const char *s) {                                                                                                                                           
                                                                                                                                                                        
    fprintf(stderr, "%s\n", s);                                                                                                                                         
                                                                                                                                                                        
}                                                                                                                                                                       
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
int main() {                                                                                                                                                            
                                                                                                                                                                        
    printf("Enter postfix expression:\n");                                                                                                                              
                                                                                                                                                                        
    yyparse();                                                                                                                                                          
                                                                                                                                                                        
    return 0;                                                                                                                                                           
                                                                                                                                                                        
}                                              
