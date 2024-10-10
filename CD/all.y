%{                                                                                                                                                                      
#include <stdio.h>                                                                                                                                                      
#include <stdlib.h>                                                                                                                                                     
#include "y.tab.h"                                                                                                                                                      
extern FILE *yyin;                                                                                                                                                      
void yyerror(const char *s);                                                                                                                                            
%}                                                                                                                                                                      
%token WHILE FOR NUM ID LE GE EQ NE OR AND IF ELSE                                                                                                                      
%right '='                                                                                                                                                              
%left OR                                                                                                                                                                
%left AND                                                                                                                                                               
%left '<' '>' LE GE EQ NE                                                                                                                                               
%left '+' '-'                                                                                                                                                           
%left '*' '/'                                                                                                                                                           
%right UMINUS                                                                                                                                                           
%left '!'                                                                                                                                                               
%%                                                                                                                                                                      
prog: S prog                                                                                                                                                            
    |                                                                                                                                                                   
    ;                                                                                                                                                                   
S: ST1 { printf("Input Accepted!!!\n"); }                                                                                                                               
  ;                                                                                                                                                                     
ST1: WHILE '(' E2 ')' '{' ST '}'                                                                                                                                        
   | FOR '(' E ';' E2 ';' E ')' '{' ST '}'                                                                                                                              
   | IF '(' E ')' '{' ST '}' ELSE '{' ST '}'                                                                                                                            
   ;                                                                                                                                                                    
ST: E ';' ST                                                                                                                                                            
   |                                                                                                                                                                    
   ;                                                                                                                                                                    
E: ID '=' E                                                                                                                                                             
  | E '+' E                                                                                                                                                             
  | E '-' E                                                                                                                                                             
  | E '*' E                                                                                                                                                             
  | E '/' E                                                                                                                                                             
  | E '<' E                                                                                                                                                             
  | E '>' E                                                                                                                                                             
  | E LE E                                                                                                                                                              
  | E GE E                                                                                                                                                              
  | E EQ E                                                                                                                                                              
  | E NE E                                                                                                                                                              
  | E OR E                                                                                                                                                              
  | E AND E                                                                                                                                                             
  | ID                                                                                                                                                                  
  | NUM                                                                                                                                                                 
  ;                                                                                                                                                                     
E2: E '<' E                                                                                                                                                             
   | E '>' E                                                                                                                                                            
   | E LE E                                                                                                                                                             
   | E GE E                                                                                                                                                             
   | E EQ E                                                                                                                                                             
   | E NE E                                                                                                                                                             
   | E OR E                                                                                                                                                             
   | E AND E                                                                                                                                                            
   | ID                                                                                                                                                                 
   | NUM                                                                                                                                                                
   ;                                                                                                                                                                    
%%                                                                                                                                                                      
void yyerror(const char *s) {                                                                                                                                           
    printf("Error: %s\n", s);                                                                                                                                           
}                                                                                                                                                                       
int main() {                                                                                                                                                            
    yyin = fopen("sample.c", "r");                                                                                                                                      
    if (!yyin) {                                                                                                                                                        
        perror("Error opening file");                                                                                                                                   
        return 1;                                                                                                                                                       
    }                                                                                                                                                                   
    yyparse();                                                                                                                                                          
    fclose(yyin);                                                                                                                                                       
    return 0;                                                                                                                                                           
}              
