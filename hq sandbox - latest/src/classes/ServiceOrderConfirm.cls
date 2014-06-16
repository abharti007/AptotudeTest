public with sharing class ServiceOrderConfirm {
    
    private String serviceOrderId;
    private String opporId;
    
    public CHANNEL_ORDERS__Service_Order__c serviceOrder {get; private set;}
    public Opportunity opportunity {get; private set;}
    public list<String> productNameList {get; private set;}
    
    public Pagereference init() {
        serviceOrderId = Apexpages.currentPage().getParameters().get('serviceOrderId');
        opporId = Apexpages.currentPage().getParameters().get('opporId');
        
        opportunity = [select Id, Account.Name, Pricebook2Id from Opportunity where Id= :opporId][0];
        
        serviceOrder = [select CHANNEL_ORDERS__Customer_Org_ID__c from CHANNEL_ORDERS__Service_Order__c where Id = :serviceOrderId];
        
        productNameList = getProducts();        
        return null;
    }   
    
    private list<String> getProducts() {
        set<Id> setProductsID = new set<Id>();
        for(PricebookEntry priceBookEntry :  [Select p.Product2Id, p.Pricebook2Id, p.Name, p.Id From PricebookEntry p 
                                              where Pricebook2Id = : opportunity.Pricebook2Id]) {
            setProductsID.add(priceBookEntry.Product2Id);                                       
        }
        list<OpportunityLineItem> objProducts = [ Select 
                      o.UnitPrice, 
                      o.TotalPrice, 
                      o.Quantity, 
                      o.PricebookEntryId, 
                      o.OpportunityId, 
                      o.ListPrice, 
                      o.Id 
                      From OpportunityLineItem o where PricebookEntry.Product2Id IN :setProductsID]; 
       list<String> productNameList = new list<String>();
       for (Product2 product : [Select p.ProductCode, p.Name From Product2 p where Id IN : setProductsID]) {
            productNameList.add(product.Name);
       }
       return productNameList;
    }
     
    
    public Pagereference modify() {
        return new Pagereference('/apex/ServiceOrderCreateNew?modify=true&serviceOrderId='+serviceOrderId+'&Id='+opporId);
    }
    
}