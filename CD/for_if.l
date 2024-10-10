%option noyywrap                                                                                                                                                        
%{                                                                                                                                                                      

#include <stdio.h>                                                                                                                                                      

#include <string.h>                                                                                                                                                     

char init[100], cond[100], inc[100];                                                                                                                                    

%}                                                                                                                                                                      

%%                                                                                                                                                                      

"for"[ \t]*"\("[ \t]*([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*"="[ \t]*[0-9]+[ \t]*";"[ \t]*([a-zA-Z_][a-zA-Z0-9_]*[ \t]*(<|<=|>|>=|==|!=)[ \t]*[a-zA-Z_][a-zA-Z0-9_]*)[ \t]*";"[ \
t]*([a-zA-Z_][a-zA-Z0-9_]*("++"|"--"))[ \t]*"\)"[ \t]*"{" {                                                                                                             

    sscanf(yytext, "for (%[^;]; %[^;]; %[a-zA-Z_0-9+ -])", init, cond, inc);                                                                                            

    printf("/* Converted loop */\n");                                                                                                                                   

    printf("%s\n", init);                                                                                                                                               

    printf("start:\n");                                                                                                                                                 

    printf("if (%s) {\n", cond);                                                                                                                                        

}                                                                                                                                                                       

[ \t\n]+        ;  // Ignore whitespace                                                                                                                                 

"stmt;"         { printf("    stmt;\n"); }                                                                                                                              

"}"             { printf("    %s;\n    goto start;\n} else {\n    // Code after the loop\n}\n", inc); }                                                                 

.               ;  // Ignore any other characters                                                                                                                       

%%                                                                                                                                                                      

int main() {                                                                                                                                                            

    yylex();                                                                                                                                                            

    return 0;                                                                                                                                                           

}        
