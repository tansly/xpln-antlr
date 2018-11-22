import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class Test {
    public static void main(String[] args) throws Exception {
        if (args.length != 1) {
            System.err.println("Usage: java Test <filename>");
            return;
        }

        CharStream input = CharStreams.fromFileName(args[0]);
        xplnLexer lexer = new xplnLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        xplnParser parser = new xplnParser(tokens);
        ParseTree tree = parser.start();
        if (parser.getNumberOfSyntaxErrors() != 0) {
            System.err.println("Program is ill-formed.");
            return;
        }

        System.out.println(tree.toStringTree(parser));
        System.out.println();

        CheckReturnVisitor checker = new CheckReturnVisitor();
        if (checker.visit(tree)) {
            System.out.println("All functions contain at least one return statement.");
        }
    }
}
