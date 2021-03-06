The visitor class that checks for return statements is in CheckReturnVisitor.java.
The main program is in Test.java.

Compile with:
```
$ antlr4 -visitor xpln.g4
$ javac *.java
```
Run with:
```
$ java Test <filename>
```
where `<filename>` is replaced with an input filename (name of an xpln source file).
It will print the parse tree in LISP format, then check if all functions
contain at least one return statement and report the ones that don't.

There are example xpln programs in the ./test directory.
I tried to give descriptive names to the test programs.

Notes:
* I have extended the grammar to distinguish between formal and actual parameters.
Formal parameters (in function definitions) must be identifiers. Actual parameters
(at call site) can be any kind of expression.
* ANTLR 4.7.1 is used.
