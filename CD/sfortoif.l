%option noyywrap                                                                                                                                                        

%{                                                                                                                                                                      

#include <stdio.h>                                                                                                                                                      

#include <string.h>                                                                                                                                                     

char init_outer[100], cond_outer[100], inc_outer[100];                                                                                                                  

char init_inner[100], cond_inner[100], inc_inner[100];                                                                                                                  

int loop_level = 0;                                                                                                                                                     

%}                                                                                                                                                                      

%%                                                                                                                                                                      

"for"[ \t]*"\("[ \t]*([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*"="[ \t]*[0-9]+[ \t]*";"[ \t]*([a-zA-Z_][a-zA-Z0-9_]*[ \t]*(<|<=|>|>=|==|!=)[ \t]*[a-zA-Z_][a-zA-Z0-9_]*)[ \t]*";"[ \
t]*([a-zA-Z_][a-zA-Z0-9_]*("++"|"--"))[ \t]*"\)"[ \t]*"{" {                                                                                                             

    if (loop_level == 0) {                                                                                                                                              

        sscanf(yytext, "for (%[^;]; %[^;]; %[a-zA-Z_0-9+ -])", init_outer, cond_outer, inc_outer);                                                                      

        printf("/* Converted outer loop */\n");                                                                                                                         

        printf("%s\n", init_outer);                                                                                                                                     

        printf("start_outer:\n");                                                                                                                                       

        printf("    if (%s) {\n", cond_outer);                                                                                                                          

        loop_level++;                                                                                                                                                   

    } else if (loop_level == 1) {                                                                                                                                       

        sscanf(yytext, "for (%[^;]; %[^;]; %[a-zA-Z_0-9+ -])", init_inner, cond_inner, inc_inner);                                                                      

        printf("    /* Converted inner loop */\n");                                                                                                                     

        printf("    %s\n", init_inner);                                                                                                                                 

        printf("    start_inner:\n");                                                                                                                                   

        printf("        if (%s) {\n", cond_inner);                                                                                                                      

        loop_level++;                                                                                                                                                   

    }                                                                                                                                                                   

}                                                                                                                                                                       

[ \t\n]+        ;  // Ignore whitespace                                                                                                                                 

"stmt;"         {                                                                                                                                                       

    if (loop_level > 0) {                                                                                                                                               

        if (loop_level == 1) {                                                                                                                                          

            printf("    stmt;\n");                                                                                                                                      

        } else if (loop_level == 2) {                                                                                                                                   

            printf("        stmt;\n");                                                                                                                                  

        }                                                                                                                                                               

    }                                                                                                                                                                   

}                                                                                                                                                                       

"}"             {                                                                                                                                                       

    if (loop_level == 2) {                                                                                                                                              

        printf("        %s;\n", inc_inner);                                                                                                                             

        printf("        goto start_inner;\n");                                                                                                                          

        printf("    } else {\n");                                                                                                                                       

        loop_level--;                                                                                                                                                   

    } else if (loop_level == 1) {                                                                                                                                       

        printf("    %s;\n", inc_outer);                                                                                                                                 

        printf("    goto start_outer;\n");                                                                                                                              

        printf("} else {\n");                                                                                                                                           

        loop_level--;                                                                                                                                                   

    }                                                                                                                                                                   

    if (loop_level == 0) {                                                                                                                                              

        printf("    // Code after the outer loop\n");                                                                                                                   

    } else if (loop_level == 1) {                                                                                                                                       

        printf("        // Code after the inner loop\n");                                                                                                               

    }                                                                                                                                                                   

    printf("    }\n");                                                                                                                                                  

}                                                                                                                                                                       

.               ;                                                                                                                                                       

%%                                                                                                                                                                      

int main() {                                                                                                                                                            

    yylex();                                                                                                                                                            

    return 0;                                                                                                                                                           

}          
