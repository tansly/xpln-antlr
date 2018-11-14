grammar xpln;

/*
 * Part for the parser.
 * Currently covers the XP language (not XPLN).
 * TODO: Extend for XPLN.
 */

assign :
    | ID ':=' expr
    ;

expr :
    | expr '-' term
    | expr '+' term
    | term
    ;

term :
    | term '*' factor
    | term '/' factor
    | factor
    ;

factor :
    | ID
    | NUM
    | '(' expr ')'
    ;


/*
 * Part for the lexer.
 */
ID : [A-Za-z]([A-Za-z]|[0-9])* ;
NUM : [0-9]+ ; // TODO: Floating point literals
WHITESPACE : [ \t\r\n]+ -> skip ;
