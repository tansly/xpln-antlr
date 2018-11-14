import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class Test {
    public static void main(String[] args) throws Exception {
        ANTLRInputStream input = new ANTLRInputStream(System.in);
        xplnLexer lexer = new xplnLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        xplnParser parser = new xplnParser(tokens);
        ParseTree tree = parser.assign();
        System.out.println(tree.toStringTree(parser));
    }
}
