package com.knock.taxi.context;

public abstract class AbstractKnockContext {

    private ContextResult contextResult;

    public ContextResult getResult(){
        return this.contextResult;
    }

    protected void setResult(ContextResult contextResult){
        this.contextResult = contextResult;
    }
}
