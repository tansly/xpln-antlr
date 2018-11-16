import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

import java.util.HashMap;
import java.util.Map;

class EvalVisitor extends xplnBaseVisitor<Double> {
    @Override
    public Double visitExprAdd(xplnParser.ExprAddContext ctx) {
        return visit(ctx.expr()) + visit(ctx.term());
    }

    @Override
    public Double visitTermMul(xplnParser.TermMulContext ctx) {
        return visit(ctx.term()) * visit(ctx.factor());
    }

    @Override
    public Double visitFactorNum(xplnParser.FactorNumContext ctx) {
        return Double.valueOf(ctx.NUM().getText());
    }
}

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
