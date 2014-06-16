public with sharing class OppFlowExtension {

    //Instance of the flow
    public Flow.Interview.Order_wizard myflow {get; set;}
    public String strOppId{get;set;}
    public String quantity {get;set;}
    public String strOrderNames{get;set;} 
    public static final String STR_OPPID = 'Id';
    public Opportunity objOpp{get;set;} 
    public set<Id> setOrderID = new set<Id>();
    public set<Id> setProductsID = new set<Id>(); 
    public set<Id> setServiceID = new set<Id>();
    public set<Id> setProductCatalog = new set<Id>();
     public list<OpportunityLineItem> objProducts{get;set;}
    public list<ChargentOrders__ChargentOrder__c> objOrders{get;set;}
    public list<CHANNEL_ORDERS__Partner_Product_Catalog__c> objProductCatalog{get;set;} 
    public list<Product2> productNames {get;set;}
     
     
    public String OrderId {
                            get {
                                 return (myflow != null) ? (String) myflow.getVariableValue('orderId') : null; 
                                }
                                
                            set { OrderId = value; }
                               
                          }
    

   public OppFlowExtension(ApexPages.StandardController controller) {
   
    strOppId = ApexPages.currentPage().getParameters().get(STR_OPPID); 
   
    system.debug('-------strOppId----------' + strOppId );
     if(strOppId != Null && strOppId != ''){
        objOpp = [Select o.Name, o.Id, o.Pricebook2Id,
                 (Select Id, 
                 OpportunityId,
                 PricebookEntryId,
                 Quantity, 
                 TotalPrice, 
                 UnitPrice,
                 ListPrice, 
                 Description
                 From OpportunityLineItems), 
                 (Select Id,Name, 
                 ChargentOrders__Billing_First_Name__c, 
                 ChargentOrders__Billing_Last_Name__c, 
                 ChargentOrders__Invoice_Number__c 
                 From Orders__r),(Select Name, 
                 CHANNEL_ORDERS__Customer__c, 
                 CHANNEL_ORDERS__Full_Customer_Company_Name__c,
                 CHANNEL_ORDERS__Related_Opportunity__c 
                 From CHANNEL_ORDERS__Service_Orders__r) 
                 From Opportunity o
                 Where Id =: strOppId];
     }
      system.debug('-------objOpp ----------' + objOpp );
      for(ChargentOrders__ChargentOrder__c objOrderID : objOpp.Orders__r){
         setOrderID.add(objOrderID.Id);
          system.debug('-------objOrderID----------' + objOrderID);
     }
    
        
        
        for(PricebookEntry priceBookEntry : 
        [Select p.Product2Id, p.Pricebook2Id, p.Name, p.Id From PricebookEntry p 
        where Pricebook2Id = : objOpp.Pricebook2Id]){
        
        setProductsID.add(priceBookEntry.Product2Id);
        system.debug('-------setProductsID----------' + setProductsID);
        system.debug('-------priceBookEntry ----------' + priceBookEntry );
        }
        
      objProducts = [ Select 
                      o.UnitPrice, 
                      o.TotalPrice, 
                      o.Quantity, 
                      o.PricebookEntryId, 
                      o.OpportunityId, 
                      o.ListPrice, 
                      o.Id 
                      From OpportunityLineItem o where PricebookEntry.Product2Id IN :setProductsID]; 
       
       
                      
      system.debug('-------objProducts ----------' + objProducts ); 
     
     productNames = new list<Product2>();
     productNames  = [Select p.ProductCode, p.Name From Product2 p where Id IN : setProductsID];
     system.debug('-------productNames  ----------' + productNames  ); 
     system.debug('-------productNames  ----------' + productNames[0].Name  ); 
     system.debug('-------productNames  ----------' + productNames[1].Name  ); 
     objOrders = [Select Id,Name, 
                 ChargentOrders__Billing_First_Name__c, 
                 ChargentOrders__Billing_Last_Name__c, 
                 ChargentOrders__Invoice_Number__c  From ChargentOrders__ChargentOrder__c  where ID IN :setOrderID];
                 system.debug('-------objOrders ----------' + objOrders );
            
     strOrderNames = '';  
                 
        for(ChargentOrders__ChargentOrder__c  o : objOrders ){
              strOrderNames += o.Name + ',';
        } 
        strOrderNames = strOrderNames.removeEnd(',');
        system.debug('-------strOrderNames----------' + strOrderNames);     
  
      
     
        objProductCatalog = [Select c.Name, 
                             c.Id, 
                             c.CHANNEL_ORDERS__Status__c, 
                             c.CHANNEL_ORDERS__Product_ID__c,
                             c.CHANNEL_ORDERS__Product_Description__c, 
                             c.CHANNEL_ORDERS__Pricing_Unit__c, 
                             c.CHANNEL_ORDERS__Pricing_Type__c, 
                             c.CHANNEL_ORDERS__PNR__c, 
                             c.CHANNEL_ORDERS__Floor_Price__c, 
                             c.CHANNEL_ORDERS__Fixed_Price__c, 
                             c.CHANNEL_ORDERS__Custom_Unit__c 
                             From CHANNEL_ORDERS__Partner_Product_Catalog__c c];
                             
                              system.debug('-------objProductCatalog ----------' + objProductCatalog );
                              
                              for(CHANNEL_ORDERS__Partner_Product_Catalog__c objProduct : objProductCatalog ) {
                              
                              setProductCatalog.add(objProduct.Id );
                             // setProductCatalog.add(objProduct.CHANNEL_ORDERS__Pricing_Unit__c);
                             // setProductCatalog.add(objProduct.CHANNEL_ORDERS__Floor_Price__c);
                             // setProductCatalog.add(objProduct.CHANNEL_ORDERS__Fixed_Price__c);
                            //  setProductCatalog.add(objProduct.CHANNEL_ORDERS__Pricing_Type__c);
                              
                             // setProductCatalog.add(objProduct.CHANNEL_ORDERS__Status__c);
                            //  setProductCatalog.add(objProduct.CHANNEL_ORDERS__Product_ID__c);
                            //  setProductCatalog.add(objProduct.CHANNEL_ORDERS__Product_Description__c);
                            //  setProductCatalog.add(objProduct.CHANNEL_ORDERS__PNR__c);
                            //  setProductCatalog.add(objProduct.CHANNEL_ORDERS__Custom_Unit__c );
                              
                               system.debug('-------setProductCatalog----------' + setProductCatalog);
                             
                               
                              }
                              
                              
                              
                              
        /* objProductCatalogNew = [Select c.Name, 
                             c.Id, 
                             c.CHANNEL_ORDERS__Status__c, 
                             c.CHANNEL_ORDERS__Product_ID__c,
                             c.CHANNEL_ORDERS__Product_Description__c, 
                             c.CHANNEL_ORDERS__Pricing_Unit__c, 
                             c.CHANNEL_ORDERS__Pricing_Type__c, 
                             c.CHANNEL_ORDERS__PNR__c, 
                             c.CHANNEL_ORDERS__Floor_Price__c, 
                             c.CHANNEL_ORDERS__Fixed_Price__c, 
                             c.CHANNEL_ORDERS__Custom_Unit__c 
                             From CHANNEL_ORDERS__Partner_Product_Catalog__c c where Id IN :setProductCatalog]; 
                             
                              system.debug('-------objProductCatalogNew ----------' + objProductCatalogNew );*/
                                    
     
    /*  system.debug('-------objServiceOrder ----------' + objServiceOrder );
      for(CHANNEL_ORDERS__Service_Order__c objSO: objServiceOrder)
      {
          system.debug('-------objSO.CHANNEL_ORDERS__Partner_Order_Detail__r-------'+objSO.CHANNEL_ORDERS__Partner_Order_Detail__r);
      }*/
     
  
   }
 
}