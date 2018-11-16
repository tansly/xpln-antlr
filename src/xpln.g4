grammar xpln;

/*
 * Part for the parser.
 * Currently covers the XP language (not XPLN).
 * TODO: Extend for XPLN.
 */

assign :
    | ID ':=' expr
    ;

/*
 * According to "The Definitive ANTLR 4 Reference", section 5.4,
 * ANTLR can ambiguities in favor of the alternative given first,
 * implicitly allowing us to specify operator precedence.
 *
 * I have taken the classical approach, instead of letting ANTLR resolve the
 * ambiguity. Evaluate both approaches and decide on which to favor.
 */
expr :
    | expr SUB term
    | expr ADD term
    | term
    ;

term :
    | term MUL factor
    | term DIV factor
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
ADD : '+' ;
SUB : '-' ;
MUL : '*' ;
DIV : '/' ;
