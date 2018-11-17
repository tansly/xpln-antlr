import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

import java.util.HashMap;
import java.util.Map;

public class Test {
    public static void main(String[] args) throws Exception {
        ANTLRInputStream input = new ANTLRInputStream(System.in);
        xplnLexer lexer = new xplnLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        xplnParser parser = new xplnParser(tokens);
        ParseTree tree = parser.expr();
        System.out.println(tree.toStringTree(parser));

        /*
        EvalVisitor eval = new EvalVisitor();
        System.out.println(eval.visit(tree));
        */
    }
}
