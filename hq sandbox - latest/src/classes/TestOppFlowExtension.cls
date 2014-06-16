@isTest
public with sharing class TestOppFlowExtension {

private static testmethod void processFlowExecution(){

    ApexPages.StandardController controller = new ApexPages.StandardController(new Opportunity());
    OppFlowExtension ext = new OppFlowExtension(controller);
    ext.myflow = null;
    String testGetOrder = ext.OrderId;
    System.assertEquals(null,testGetOrder);

}

}