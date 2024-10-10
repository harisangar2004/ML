%{                                                                                                                                                                      
#include <stdio.h>                                                                                                                                                      
#include <stdlib.h>                                                                                                                                                     
#include <string.h>                                                                                                                                                     
                                                                                                                                                                        
void yyerror(const char *s);                                                                                                                                            
extern int yylex();                                                                                                                                                     
extern FILE *yyin;                                                                                                                                                      
int success = 1;                                                                                                                                                        
                                                                                                                                                                        
typedef union {                                                                                                                                                         
    int num;                                                                                                                                                            
    char *str;                                                                                                                                                          
    char ch;                                                                                                                                                            
} YYSTYPE;                                                                                                                                                              
                                                                                                                                                                        
#define YYSTYPE_IS_DECLARED 1                                                                                                                                           
   %}                                                                                                                                                                   
                                                                                                                                                                        
/* Operator precedence and associativity */                                                                                                                             
%left '+' '-'                                                                                                                                                           
%left '*' '/'                                                                                                                                                           
                                                                                                                                                                        
%token SWITCH CASE DEFAULT BREAK NUMBER STRING CHAR IDENTIFIER COLON LBRACE RBRACE SEMICOLON                                                                            
%union {                                                                                                                                                                
    int num;                                                                                                                                                            
    char *str;                                                                                                                                                          
    char ch;                                                                                                                                                            
}                                                                                                                                                                       
                                                                                                                                                                        
%%                                                                                                                                                                      
                                                                                                                                                                        
switch_stmt : SWITCH '(' expr ')' LBRACE case_list default_opt RBRACE                                                                                                   
            | SWITCH '(' expr ')' LBRACE default_opt RBRACE                                                                                                             
            ;                                                                                                                                                           
                                                                                                                                                                        
case_list   : case_stmt                                                                                                                                                 
            | case_list case_stmt                                                                                                                                       
            ;                                                                                                                                                           
                                                                                                                                                                        
case_stmt   : CASE case_option COLON stmt_list BREAK SEMICOLON                                                                                                          
            | CASE case_option COLON BREAK SEMICOLON                                                                                                                    
            | CASE case_option COLON stmt_list                                                                                                                          
            ;                                                                                                                                                           
                                                                                                                                                                        
case_option : NUMBER                                                                                                                                                    
            | STRING                                                                                                                                                    
            | CHAR                                                                                                                                                      
            | IDENTIFIER                                                                                                                                                
            ;                                                                                                                                                           
                                                                                                                                                                        
default_opt : DEFAULT COLON stmt_list BREAK SEMICOLON                                                                                                                   
            | DEFAULT COLON BREAK SEMICOLON                                                                                                                             
            | DEFAULT COLON                                                                                                                                             
            | /* empty */                                                                                                                                               
            ;                                                                                                                                                           
                                                                                                                                                                        
stmt_list   : stmt                                                                                                                                                      
            | stmt_list stmt                                                                                                                                            
            ;                                                                                                                                                           
                                                                                                                                                                        
stmt        : expr SEMICOLON         // Expression statements                                                                                                           
            | IDENTIFIER '=' expr SEMICOLON  // Assignment statements                                                                                                   
            ;                                                                                                                                                           
                                                                                                                                                                        
expr        : NUMBER                                                                                                                                                    
            | STRING                                                                                                                                                    
            | CHAR                                                                                                                                                      
            | IDENTIFIER                                                                                                                                                
            | IDENTIFIER '(' ')'    // Function calls (simplified, no arguments)                                                                                        
            | expr '+' expr         // Basic arithmetic                                                                                                                 
            | expr '-' expr                                                                                                                                             
            | expr '*' expr                                                                                                                                             
            | expr '/' expr                                                                                                                                             
            ;                                                                                                                                                           
                                                                                                                                                                        
%%                                                                                                                                                                      
                                                                                                                                                                        
void yyerror(const char *s) {                                                                                                                                           
    success = 0;                                                                                                                                                        
    fprintf(stderr, "Error: %s\n", s);                                                                                                                                  
}                                                                                                                                                                       
                                                                                                                                                                        
int main(int argc, char **argv) {                                                                                                                                       
    if (argc == 2) {                                                                                                                                                    
        FILE *inputFile = fopen(argv[1],"r");                                                                                                                           
        if (!inputFile) {                                                                                                                                               
                perror("Error opening  file");
                exit(1);                                                                                                                                                
        }                                                                                                                                                               
        char line[1024];                                                                                                                                                
        printf("Input:\n");                                                                                                                                             
        while(fgets(line,sizeof(line),inputFile)) {                                                                                                                     
                printf("%s",line);                                                                                                                                      
        }                                                                                                                                                               
        rewind(inputFile);                                                                                                                                              
        yyin = inputFile;                                                                                                                                               
    }                                                                                                                                                                   
    if (yyparse() ==0 && success) {                                                                                                                                     
        printf("Valid syntax\n");                                                                                                                                       
    }                                                                                                                                                                   
    return 0;                                                                                                                                                           
}                 
