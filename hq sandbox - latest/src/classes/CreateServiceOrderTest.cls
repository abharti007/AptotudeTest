@isTest
private class CreateServiceOrderTest {

    static testMethod void testCreateServiceOrder() {
        // TO DO: implement unit test
     /*     String orgId = '00Di0000000hXD5';
            String contractId = 'a0fV0000001UYRH';
        
            CHANNEL_ORDERS__Service_Order__c order1 = new CHANNEL_ORDERS__Service_Order__c(
            CHANNEL_ORDERS__Customer_Org_ID__c = orgId,
            CHANNEL_ORDERS__Partner_Contract_Rules__c = contractId, 
            CHANNEL_ORDERS__Order_Type__c = 'Initial',
            CHANNEL_ORDERS__Service_Start_Date__c = Date.today()
             
        );
            insert order1; 
            
            CHANNEL_ORDERS__Service_Order_Detail__c serviceorder = new CHANNEL_ORDERS__Service_Order_Detail__c(
            CHANNEL_ORDERS__Partner_Order__c = order1.Id,
            CHANNEL_ORDERS__Product_Name__c = 'Apto Commercial Real Estate Broker - 1 Customer System Admin - Annual License'
            
         );
            insert serviceorder;*/
            
            Account acc = new Account(Name = 'lastAccount');
            insert acc;
            
            Opportunity opp = new Opportunity();
            opp.Name = 'testOpportunity';
            opp.CloseDate = Date.today();
            opp.AccountId = acc.Id;
            opp.StageName = 'In Trial';
            opp.Type = 'New Business';
            opp.Amount = 100.00;
            opp.Type__c = 'Recurring License';
            opp.Persona__c = 'Office';
            opp.LeadSource = 'INBOUND - Web- Trial Sign Up';
            insert opp;
    }
}