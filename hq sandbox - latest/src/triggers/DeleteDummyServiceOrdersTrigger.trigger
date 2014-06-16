trigger DeleteDummyServiceOrdersTrigger on CHANNEL_ORDERS__Service_Order__c (after insert) {

    //Create a list to hold all new records
    List<CHANNEL_ORDERS__Service_Order__c> newRecords = new List<CHANNEL_ORDERS__Service_Order__c>();
    List<CHANNEL_ORDERS__Service_Order__c> toDelete = new List<CHANNEL_ORDERS__Service_Order__c>();
    
    //Loop around all records in the trigger transaction
    for(CHANNEL_ORDERS__Service_Order__c theRecord : Trigger.new){
        //Evaluate the record against our criteria
        if(theRecord.Marked_for_Deletion__c == false){
            //The line below creates a new CHANNEL_ORDERS__Service_Order__c record and adds it to our list of new records. Add your field assigments (examples below). Make sure to assign all required fields.
           toDelete = [Select Id from CHANNEL_ORDERS__Service_Order__c where Marked_for_Deletion__c = true];
           
        }
    }
    
    delete toDelete;

}