public with sharing class CreateServiceOrder {

    static map<String,Schema.SObjectType> sobjectMap = Schema.getGlobalDescribe();
 
    public Opportunity objOpp{get;set;}
    public Account objAcc{get;set;}
    public sfLma__License__c objLicense{get;set;}
    public CHANNEL_ORDERS__Service_Order__c objServiceOrder{get;set;}
    public CHANNEL_ORDERS__Partner_Product_Catalog__c objPartnerProductCatelog{get;set;}
    public String strOppId{get;set;}
    public set<Id> setOrderID = new set<Id>();
    public String strOrderNames{get;set;}
    public list<ChargentOrders__ChargentOrder__c> objOrders{get;set;}
    public list<Product2> productNames {get;set;}
    public list<OpportunityLineItem> lineItemList{get;set;}
    public set<Id> setProductsID = new set<Id>();
    public static final String STR_OPPID = 'Id';
    
    public map<Id, OpportunityLineItem> productVsLineItemMap {get; set;}
  
    public boolean isEditMode {get; set;}
 
    public CreateServiceOrder(ApexPages.StandardController controller) {
        isEditMode = false;
        productNames = new list<Product2>();
        objServiceOrder = new CHANNEL_ORDERS__Service_Order__c();
            
        this.objOpp = (Opportunity)controller.getRecord();
                
        objOpp = [Select o.Name,o.AccountId,o.Id, o.Pricebook2Id,
                        o.Org_ID__c, o.Org_ID_15__c, 
                        o.License__c, o.License_Status__c, 
                        o.License_Expiration_Date__c,
                        o.License_End_Date__c,
                        o.License_Discount__c, 
                        o.License_Cost_User_Month__c,
                        o.Account.Name,
                        o.Account.BillingStreet, 
                        o.Account.BillingState,
                        o.Account.BillingPostalCode,
                        o.Account.BillingCountry,
                        o.Account.BillingCity,
                        o.Account.Phone,
                        
                         (Select Id,Name, 
                         ChargentOrders__Billing_First_Name__c, 
                         ChargentOrders__Billing_Last_Name__c, 
                         ChargentOrders__Invoice_Number__c 
                         From Orders__r),
                         
                         (Select Name, 
                         sfLma__Account__c, 
                         sfLma__License_Status__c, 
                         sfLma__License_Type__c, 
                         sfLma__Package_License_ID__c, 
                         sfLma__Subscriber_Org_ID__c, 
                         Opportunity__c From Licenses__r),
                         
                         (Select Name, 
                         CHANNEL_ORDERS__Customer__c, 
                         CHANNEL_ORDERS__Full_Customer_Company_Name__c,
                         CHANNEL_ORDERS__Date_Partner_Received_Customer_Order__c,
                         CHANNEL_ORDERS__Related_Opportunity__c 
                         From CHANNEL_ORDERS__Service_Orders__r) 
                         From Opportunity o
                         Where Id =: objOpp.Id];
                         
        objServiceOrder.CHANNEL_ORDERS__Related_Opportunity__c = objOpp.Id;        
        
        list<sfLma__License__c> licenseList = [Select Name, 
                                                   sfLma__Account__c, 
                                                   sfLma__License_Status__c, 
                                                   sfLma__License_Type__c, 
                                                   sfLma__Package_License_ID__c, 
                                                   sfLma__Subscriber_Org_ID__c, 
                                                   Opportunity__c From sfLma__License__c Where Id =: objOpp.License__c ];
                           
        objLicense = (licenseList != null && licenseList.size()>0) ? licenseList[0] : new sfLma__License__c();
     
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
        
        set<Id> prodIdSet = new set<Id>();
        
        lineItemList = [ Select 
                      o.UnitPrice, 
                      o.TotalPrice, 
                      o.Quantity, 
                      o.PricebookEntryId, 
                      o.OpportunityId, 
                      o.ListPrice, 
                      o.Id, 
                      o.PricebookEntry.Product2.Id,
                      o.Partner_Product_Catalog__c,
                      o.Partner_Product_Catalog__r.Name,
                      o.Partner_Product_Catalog__r.CHANNEL_ORDERS__Pricing_Type__c,
                      o.Partner_Product_Catalog__r.CHANNEL_ORDERS__Pricing_Unit__c,
                      o.Partner_Product_Catalog__r.CHANNEL_ORDERS__Application__c 
                      From OpportunityLineItem o where PricebookEntry.Product2Id IN :setProductsID]; 
        //productNames  = [Select p.ProductCode, p.Name From Product2 p where Id IN : setProductsID];
        
        //[select Id, PricebookEntry.Product2.Name  from OpportunityLineItem ]
        productVsLineItemMap = new map<Id, OpportunityLineItem>();
        for (OpportunityLineItem item : lineItemList) {
           productVsLineItemMap.put(item.PricebookEntry.Product2.Id, item);
           prodIdSet.add(item.PricebookEntry.Product2.Id);
        }
        
        productNames = [
                select ProductCode
                     , Name 
                     , Partner_Product_Catalog__c
                     , Partner_Product_Catalog__r.Name
                     , Partner_Product_Catalog__r.CHANNEL_ORDERS__Pricing_Type__c
                     , Partner_Product_Catalog__r.CHANNEL_ORDERS__Pricing_Unit__c
                     , Partner_Product_Catalog__r.CHANNEL_ORDERS__Application__c 
                  From Product2 where Id IN : prodIdSet /*setProductsID*/
        ];
        
        system.debug('===productVsLineItemMap==='+productVsLineItemMap);
    } 
  
    public Pagereference modify() {
        isEditMode = false; 
        return null;
    }
  
    /*private CHANNEL_ORDERS__Service_Order__c getServiceOrder(String serviceOrderId) {
        list <CHANNEL_ORDERS__Service_Order__c> serviceOrderList = [
                        select Name
                             , CHANNEL_ORDERS__Customer__c
                             , CHANNEL_ORDERS__Full_Customer_Company_Name__c
                             , CHANNEL_ORDERS__Date_Partner_Received_Customer_Order__c
                             , CHANNEL_ORDERS__Service_Start_Date__c
                             , CHANNEL_ORDERS__Partner_Contract_Rules__c 
                             , CHANNEL_ORDERS__Related_Opportunity__c
                             , CHANNEL_ORDERS__Order_Type__c 
                          FROM CHANNEL_ORDERS__Service_Order__c
                         WHERE Id = :serviceOrderId 
        ];
        return (serviceOrderList != null && serviceOrderList.size()>0) ? serviceOrderList[0] : null;
    }
    */
  
    public List<selectOption> getContracts() {
        List<selectOption> options = new List<selectOption>(); 
        for (CHANNEL_ORDERS__Partner_Contract_Terms__c contractTerms : [Select c.Name, c.Id From CHANNEL_ORDERS__Partner_Contract_Terms__c c]) { 
            options.add(new selectOption(contractTerms.Id, contractTerms.Name));
        }
        return options; 
    }
  
    public List<selectOption> getServiceOrders() {
        List<selectOption> options = getPickListOptions('CHANNEL_ORDERS__Service_Order__c', 'CHANNEL_ORDERS__Order_Type__c');
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
        
    public Pagereference next() {
          isEditMode = true;
          return null;
    }
    
    public Pagereference saveRecords() {
        boolean isReturn = false;
        try {
          objServiceOrder.CHANNEL_ORDERS__Customer_Org_ID__c = objLicense.sfLma__Subscriber_Org_ID__c;
          Database.Upsertresult result = Database.upsert(objServiceOrder);
          
          list<CHANNEL_ORDERS__Service_Order_Detail__c> prodCatalogInsertList = new list<CHANNEL_ORDERS__Service_Order_Detail__c>();
          
           /* for (OpportunityLineItem lineItem : lineItemList) {
                CHANNEL_ORDERS__Service_Order_Detail__c serviceOrDetails = new CHANNEL_ORDERS__Service_Order_Detail__c();
                serviceOrDetails.CHANNEL_ORDERS__Partner_Order__c = result.getId();
                serviceOrDetails.CHANNEL_ORDERS__Product_Name__c = lineItem.Partner_Product_Catalog__r.Id;
                serviceOrDetails.CHANNEL_ORDERS__Quantity__c = lineItem.Quantity;
                serviceOrDetails.CHANNEL_ORDERS__Customer_Price_Per_Month__c = lineItem.UnitPrice;
                serviceOrDetails.CHANNEL_ORDERS__pc_Pricing_Type__c = lineItem.Partner_Product_Catalog__r.CHANNEL_ORDERS__Pricing_Type__c;
                serviceOrDetails.CHANNEL_ORDERS__pc_Pricing_Unit__c = lineItem.Partner_Product_Catalog__r.CHANNEL_ORDERS__Pricing_Unit__c;
                serviceOrDetails.CHANNEL_ORDERS__Application__c = lineItem.Partner_Product_Catalog__r.CHANNEL_ORDERS__Application__c;
                prodCatalogInsertList.add(serviceOrDetails);
            }
            */
            for (Product2 product : productNames) {
                CHANNEL_ORDERS__Service_Order_Detail__c serviceOrDetails = new CHANNEL_ORDERS__Service_Order_Detail__c();
                serviceOrDetails.CHANNEL_ORDERS__Partner_Order__c = result.getId();
                serviceOrDetails.CHANNEL_ORDERS__Quantity__c = productVsLineItemMap.get(product.Id).Quantity;
                serviceOrDetails.CHANNEL_ORDERS__Customer_Price_Per_Month__c = productVsLineItemMap.get(product.Id).UnitPrice;
                serviceOrDetails.CHANNEL_ORDERS__Product_Name__c = product.Partner_Product_Catalog__r.Id;
                serviceOrDetails.CHANNEL_ORDERS__pc_Pricing_Type__c = product.Partner_Product_Catalog__r.CHANNEL_ORDERS__Pricing_Type__c;
                serviceOrDetails.CHANNEL_ORDERS__pc_Pricing_Unit__c = product.Partner_Product_Catalog__r.CHANNEL_ORDERS__Pricing_Unit__c;
                serviceOrDetails.CHANNEL_ORDERS__Application__c = product.Partner_Product_Catalog__r.CHANNEL_ORDERS__Application__c;
                prodCatalogInsertList.add(serviceOrDetails);
            }
            
            if (prodCatalogInsertList.size()>0) 
              insert prodCatalogInsertList;
        } catch(Exception ex) {
            //ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, ex.getMessage()));
            system.debug('==Exception=='+ex);
        }
        //Pagereference page = (isReturn == true)? new PageReference('/'+objServiceOrder.CHANNEL_ORDERS__Related_Opportunity__c) : null;
        return  new PageReference('/'+objServiceOrder.Id);
    } 
    
    public PageReference cancel() {
        PageReference page = new PageReference('/'+objServiceOrder.CHANNEL_ORDERS__Related_Opportunity__c); 
        page.setRedirect(true);
        return page;
    }
    

}