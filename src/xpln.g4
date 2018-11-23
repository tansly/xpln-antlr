grammar xpln;

/*
 * Part for the parser.
 */

start : stmt ';' (entry ';')* EOF
      ;

entry : stmt
      | def
      ;

stmts : (stmt ';')+
      ;

stmt : assign
     | ifcond
     | wh
     | ret
     | io
     ;

assign : ID ':=' expr
       ;

ifcond : 'if' cond stmts 'endi'
       | 'if' cond stmts 'else' stmts 'endi'
       ;

wh : 'while' cond stmts 'endw'
   ;

ret : 'return' expr
    ;

io : 'input' ID
   | 'output' ID
   ;

def : 'fun' ID plist stmts 'endf'
    ;

plist : '(' args ')'
      ;

args : expr ',' args
     | expr
     | /* epsilon (no arguments) */
     ;

fcall : ID plist
      ;

cond : expr (LT|LTE|EQ|GT|GTE) expr
     | cond (AND|OR) cond
     | UOP cond
     ;

/*
 * According to "The Definitive ANTLR 4 Reference", section 5.4,
 * ANTLR can ambiguities in favor of the alternative given first,
 * implicitly allowing us to specify operator precedence.
 *
 * I have taken the classical approach, instead of letting ANTLR resolve the
 * ambiguity.
 */
expr : expr SUB term     # ExprSub
     | expr ADD term     # ExprAdd
     | term              # ExprTerm
     ;

term : term MUL factor   # TermMul
     | term DIV factor   # TermDiv
     | factor            # TermFactor
     ;

factor : ID                # FactorId
       | NUM               # FactorNum
       | '(' expr ')'      # FactorParens
       | fcall             # FactorFcall
       ;


/*
 * Part for the lexer.
 */

NUM : [0-9]+
    | [0-9]+ '.' [0-9]*
    | '.' [0-9]+
    ;
ID : [A-Za-z]([A-Za-z]|[0-9])* ;
WHITESPACE : [ \t\r\n]+ -> skip ;

/*
 * Arithmetic operators.
 */
ADD : '+' ;
SUB : '-' ;
MUL : '*' ;
DIV : '/' ;

/*
 * Relational operators.
 */
LT : '<' ;
LTE : '<=' ;
EQ : '==' ;
GT : '>' ;
GTE : '>=' ;

/*
 * Logical operators.
 */
AND : 'and' ;
OR : 'or' ;

UOP : '!' ; // not
