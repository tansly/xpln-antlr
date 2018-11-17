import org.antlr.v4.runtime.*;

public class EvalVisitor extends xplnBaseVisitor<Double> {
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
