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
        return false;
    }
}
