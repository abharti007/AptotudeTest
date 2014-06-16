@IsTest public with sharing class DeleteDummyServiceOrdersTriggerTest {
     @IsTest(SeeAllData=true) public static void testDeleteDummySOTrigger() {
        
        String customerId = 'a09i0000006COsz';
        String orgId = '00Di0000000hXD5';
        String contractId = 'a0Ai0000003eVRt';
       
        // Create two Service Orders (one Marked for Deletion and one not)     
        CHANNEL_ORDERS__Service_Order__c order1 = new CHANNEL_ORDERS__Service_Order__c(
            CHANNEL_ORDERS__Customer_Org_ID__c = orgId,
            CHANNEL_ORDERS__Customer__c = customerId,
            CHANNEL_ORDERS__Partner_Contract_Rules__c = contractId, 
            CHANNEL_ORDERS__Date_Customer_Accepted_SFDC_Svc_Agrmnt__c = Date.today(),
            CHANNEL_ORDERS__Date_Partner_Received_Customer_Order__c = Date.today(),
            CHANNEL_ORDERS__I_certify__c = 'True',
            CHANNEL_ORDERS__Order_Type__c = 'Initial',
            CHANNEL_ORDERS__Service_Start_Date__c = Date.today(),
            Marked_for_Deletion__c = true
        );
   
        CHANNEL_ORDERS__Service_Order__c order2 = new CHANNEL_ORDERS__Service_Order__c(
            CHANNEL_ORDERS__Customer_Org_ID__c = orgId,
            CHANNEL_ORDERS__Customer__c = customerId,
            CHANNEL_ORDERS__Partner_Contract_Rules__c = contractId, 
            CHANNEL_ORDERS__Date_Customer_Accepted_SFDC_Svc_Agrmnt__c = Date.today(),
            CHANNEL_ORDERS__Date_Partner_Received_Customer_Order__c = Date.today(),
            CHANNEL_ORDERS__I_certify__c = 'True',
            CHANNEL_ORDERS__Order_Type__c = 'Initial',
            CHANNEL_ORDERS__Service_Start_Date__c = Date.today(),
            Marked_for_Deletion__c = false
        );

             
        insert order1;
        insert order2;
    
        // There should be no orders marked for deletion
        List<CHANNEL_ORDERS__Service_Order__c> markedForDeletion = [Select Id from CHANNEL_ORDERS__Service_Order__c where Marked_for_Deletion__c = true];
        System.assertEquals(0, markedForDeletion.size()); 
    }
}