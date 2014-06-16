public with sharing class OppFlowExtensionNewClone {
    

 static map<String,Schema.SObjectType> sobjectMap = Schema.getGlobalDescribe();
 
 public Opportunity objOpp{get;set;} 
 public Account objAcc{get;set;}
 public sfLma__License__c objLicense{get;set;}
 public CHANNEL_ORDERS__Service_Order__c objServiceOrder{get;set;} 
 public CHANNEL_ORDERS__Partner_Contract_Terms__c objPartnerContract{get;set;}
 public String strOppId{get;set;}
 public set<Id> setOrderID = new set<Id>();
  public String strOrderNames{get;set;}
 public list<ChargentOrders__ChargentOrder__c> objOrders{get;set;}
  public list<Product2> productNames {get;set;}
  public list<OpportunityLineItem> objProducts{get;set;}
  public set<Id> setProductsID = new set<Id>();
 public static final String STR_OPPID = 'Id';
 

 
 public OppFlowExtensionNewClone(ApexPages.StandardController controller) {

        strOppId = ApexPages.currentPage().getParameters().get(STR_OPPID); 
 

            if(strOppId != Null && strOppId != ''){
                
                objOpp = [Select o.Name,o.AccountId,o.Id, o.Pricebook2Id,
                        o.Org_ID__c, o.Org_ID_15__c, 
                        o.License__c, o.License_Status__c, 
                        o.License_Expiration_Date__c,
                        o.License_End_Date__c,
                        o.License_Discount__c, 
                        o.License_Cost_User_Month__c,
                         (Select Id,Name, 
                         ChargentOrders__Billing_First_Name__c, 
                         ChargentOrders__Billing_Last_Name__c, 
                         ChargentOrders__Invoice_Number__c 
                         From Orders__r),(Select Name, 
                         sfLma__Account__c, 
                         sfLma__License_Status__c, 
                         sfLma__License_Type__c, 
                         sfLma__Package_License_ID__c, 
                         sfLma__Subscriber_Org_ID__c, 
                         Opportunity__c From Licenses__r),
                         (Select Name, 
                         CHANNEL_ORDERS__Customer__c, 
                         CHANNEL_ORDERS__Full_Customer_Company_Name__c,
                         CHANNEL_ORDERS__Related_Opportunity__c 
                         From CHANNEL_ORDERS__Service_Orders__r) 
                         From Opportunity o
                         Where Id =: strOppId];
                   system.debug('======== objOpp ==========' + objOpp);        
                 objAcc = [Select a.Phone, 
                           a.Name, 
                           a.Id, 
                           a.BillingStreet,
                           a.BillingState, 
                           a.BillingPostalCode, 
                           a.BillingCountry, 
                           a.BillingCity 
                           From Account a Where Id =: objOpp.AccountId];
                           
                           
                 objLicense = [Select Name, 
                               sfLma__Account__c, 
                               sfLma__License_Status__c, 
                               sfLma__License_Type__c, 
                               sfLma__Package_License_ID__c, 
                               sfLma__Subscriber_Org_ID__c, 
                               Opportunity__c From sfLma__License__c Where Id =: objOpp.License__c ];
                               
                                        
     }
     
      for(ChargentOrders__ChargentOrder__c objOrderID : objOpp.Orders__r){
         setOrderID.add(objOrderID.Id);
         
     }
     
      objOrders = [Select Id,Name, 
                 ChargentOrders__Billing_First_Name__c, 
                 ChargentOrders__Billing_Last_Name__c, 
                 ChargentOrders__Invoice_Number__c  From ChargentOrders__ChargentOrder__c  where ID IN :setOrderID];
                
            
        strOrderNames = '';  
                 
        for(ChargentOrders__ChargentOrder__c  o : objOrders ){
              strOrderNames += o.Name + ',';
        } 
        
        strOrderNames = strOrderNames.removeEnd(',');
       
       
        for(PricebookEntry priceBookEntry :  [Select p.Product2Id, p.Pricebook2Id, p.Name, p.Id From PricebookEntry p 
                                              where Pricebook2Id = : objOpp.Pricebook2Id]){
            setProductsID.add(priceBookEntry.Product2Id);
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
       
    
  } 
  
           public List<selectOption> getContracts() {
                List<selectOption> options = new List<selectOption>(); 
                options.add(new selectOption('', '- None -')); 
                for (CHANNEL_ORDERS__Partner_Contract_Terms__c contractTerms : [Select c.Name, c.Id From CHANNEL_ORDERS__Partner_Contract_Terms__c c]) { 
                    options.add(new selectOption(contractTerms.Id, contractTerms.Name));
                }
                return options; 
            }
  
         public List<selectOption> getServiceOrders() {
                List<selectOption> options = getPickListOptions('CHANNEL_ORDERS__Service_Order__c', 'CHANNEL_ORDERS__Order_Type__c');
                /*options.add(new selectOption('', '- None -')); 
                for (CHANNEL_ORDERS__Service_Order__c serviceOrder : [Select  c.Name, c.Id,c.CHANNEL_ORDERS__Related_Opportunity__c, c.CHANNEL_ORDERS__Order_Type__c
                      From CHANNEL_ORDERS__Service_Order__c c ]) { 
                            
                    options.add(new selectOption(serviceOrder.Id, serviceOrder.CHANNEL_ORDERS__Order_Type__c));
                }*/
                return options; 
            }
  
         public static list<SelectOption> getPickListOptions(String objectName, String fieldName) {
             list<Selectoption> picklistOptions = new list<Selectoption>();
             Schema.Sobjecttype sobjectResult = sobjectMap.get(objectName);
             
             if (sobjectResult == null)
              return picklistOptions;
             
             map<String, Schema.SObjectField> field_map = sobjectResult.getDescribe().fields.getMap();
             
             if (field_map.get(fieldName) == null)
              return picklistOptions;
             
             list<Schema.Picklistentry> picklistValuesList = field_map.get(fieldName).getdescribe().getPickListValues();
             for(Schema.Picklistentry picklistValues : picklistValuesList) {
              picklistOptions.add(new Selectoption(picklistValues.getLabel(), picklistValues.getValue()));
             }
             
             return picklistOptions;
        }
}