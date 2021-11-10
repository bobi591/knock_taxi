package com.knock.taxi.context;

public class ContextResult {
    
    private String resultMessage;
    private ContextStatus resultStatus;

    public ContextResult(String resultMessage, ContextStatus resultStatus){
        this.resultMessage = resultMessage;
        this.resultStatus = resultStatus;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public ContextStatus getResultStatus() {
        return resultStatus;
    }
}
