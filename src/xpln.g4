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

ifcond : K_IF cond stmts K_ENDIF
       | K_IF cond stmts K_ELSE stmts K_ENDIF
       ;

wh : K_WHILE cond stmts K_ENDWHILE
   ;

ret : K_RETURN expr
    ;

io : K_INPUT ID
   | K_OUTPUT ID
   ;

def : K_FUN ID fplist stmts K_ENDFUN
    ;

/*
 * [f]ormal [p]arameter [list] must consist of identifiers.
 */
fplist : '(' fargs ')'
       ;

fargs : ID ',' fargs
      | ID
      | /* epsilon (no arguments) */
      ;

fcall : ID aplist
      ;

/*
 * Actual parameter list may consist of any kind of expressions.
 */
aplist : '(' aargs ')'
       ;

aargs : expr ',' aargs
      | expr
      | /* epsilon (no arguments) */
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

NUM : DIGIT+
    | DIGIT+ '.' DIGIT*
    | '.' DIGIT+
    ;

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
AND : A N D ;
OR : O R ;
UOP : '!' ; // not

/*
 * Misc keywords.
 */
K_IF : I F ;
K_ELSE : E L S E ;
K_ENDIF : E N D I ;
K_WHILE : W H I L E ;
K_ENDWHILE : E N D W ;
K_FUN : F U N ;
K_ENDFUN : E N D F ;
K_RETURN : R E T U R N ;
K_INPUT : I N P U T ;
K_OUTPUT : O U T P U T ;

ID : [A-Za-z]([A-Za-z0-9])* ;

WHITESPACE : [ \t\r\n]+ -> skip ;

fragment DIGIT : [0-9] ;

fragment A : [aA] ;
fragment B : [bB] ;
fragment C : [cC] ;
fragment D : [dD] ;
fragment E : [eE] ;
fragment F : [fF] ;
fragment G : [gG] ;
fragment H : [hH] ;
fragment I : [iI] ;
fragment J : [jJ] ;
fragment K : [kK] ;
fragment L : [lL] ;
fragment M : [mM] ;
fragment N : [nN] ;
fragment O : [oO] ;
fragment P : [pP] ;
fragment Q : [qQ] ;
fragment R : [rR] ;
fragment S : [sS] ;
fragment T : [tT] ;
fragment U : [uU] ;
fragment V : [vV] ;
fragment W : [wW] ;
fragment X : [xX] ;
fragment Y : [yY] ;
fragment Z : [zZ] ;
