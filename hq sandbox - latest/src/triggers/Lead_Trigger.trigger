trigger Lead_Trigger on Lead (after update) {
	List<Opportunity> opportunities = new List<Opportunity>();
	for(Lead l : Trigger.New){
		if(l.ConvertedOpportunityId != null && l.isConverted == true && Trigger.oldMap.get(l.id).isConverted == false){
			opportunities.add(new Opportunity(id = l.ConvertedOpportunityId , Billing_Contact__c = l.ConvertedContactId));		
		}
	}
	if(opportunities.size() > 0){
		update opportunities;
	}
}