trigger Trigger_SignUpRequest on SignupRequest (after update) {

//Create a list to hold all Lead records to update
    List<Lead> leadsToUpdate = new List<Lead>();
    Set<String> subscriberOrgIds = new Set<String>();

//Loop through each successful signup request made and create list of orgIds
for (signupRequest sr:trigger.new)
    {     
        //Check SignupRequest status change
        if (sr.status == 'Success')
        {
        if (sr.createdOrgId !=null)
            {
                subscriberOrgIds.add(sr.createdOrgId);
            }        
        }
    }

List<sfLma__License__c> licenses  = [select sfLma__Subscriber_Org_ID__c,sfLma__Account__c,sfLma__Contact__c, sfLma__Lead__c from sfLma__License__c where sfLma__Subscriber_Org_ID__c IN :subscriberOrgIds];   
Map<Id,Id> mapOrgIdToLeadId = new Map<Id,Id>();
    for (sfLma__License__c l:licenses)
    {
        mapOrgIdToLeadId.put(l.sfLma__Subscriber_Org_ID__c, l.sfLma__Lead__c);
    }

// Loop through each successful SignupRequest made and update corresponding Leads
for (signupRequest s:trigger.new)
    {
        //Check signup request status change
        if (s.status == 'Success')
        {
            Lead leadToUpdate = new Lead(id=mapOrgIdToLeadId.get(s.createdOrgId));
            leadToUpdate.country = s.Country;
            leadToUpdate.Company = s.Company;
            leadToUpdate.LastName = s.LastName;
            leadsToUpdate.add(leadToUpdate);     
        }
    }

    // Update the records
    if(leadsToUpdate.size() > 0)
        update leadsToUpdate;


}