import org.antlr.v4.runtime.*;

public class CheckReturnVisitor extends xplnBaseVisitor<Boolean> {
    @Override
    public Boolean defaultResult() {
        return false;
    }

    @Override
    public Boolean aggregateResult(Boolean aggregate, Boolean nextResult) {
        return aggregate.booleanValue() || nextResult.booleanValue();
    }

    @Override
    public Boolean visitRet(xplnParser.RetContext ctx) {
        return true;
    }

    @Override
    public Boolean visitStart(xplnParser.StartContext ctx) {
        boolean mainRet = visit(ctx.stmt());
        boolean funcsRet = true;
        for (xplnParser.EntryContext entryCtx : ctx.entry()) {
            if (entryCtx.stmt() != null) {
                mainRet = mainRet || visit(entryCtx.stmt()).booleanValue();
            } else if (entryCtx.def() != null) {
                boolean currDef = visit(entryCtx.def());
                funcsRet = funcsRet && currDef;
                if (!currDef) {
                    System.out.println("Function " + entryCtx.def().ID() +
                            " does not contain a return statement.");
                }
            } else {
                /*
                 * This should not happen.
                 * XXX: What about error nodes?
                 */
                throw new RuntimeException("You done messed up.");
            }
        }

        if (!mainRet) {
            System.out.println("Main body does not contain a return statement.");
        }
        /*
         * Return true iff all function bodies (including the main body)
         * contains at least one return statement.
         */
        return mainRet && funcsRet;
    }
}
