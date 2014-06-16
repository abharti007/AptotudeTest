trigger GithubIssue_State_Trigger on Github_Issue__c (after update) {
    Map<Id, List<String>> caseStatuses = new Map<Id, List<String>>();
    system.debug('inside GithubIssue_State_Trigger---------');
    // Find cases related to triggered issues that are not new or closed
    for( Github_Issue_Case_Association__c cia : [
         SELECT Case__c, // case id
                Case__r.Status, // case status
                Github_Issue__r.State__c // issue state
         FROM Github_Issue_Case_Association__c
         WHERE Github_Issue__r.Id IN :trigger.new
           AND Case__r.Status NOT IN ('New', 'Closed')] ) {
        Id caseId = cia.Case__c;
        String issueState = cia.Github_Issue__r.State__c;
		if (!caseStatuses.containsKey(caseId)) caseStatuses.put(caseId, new List<String>());
        caseStatuses.get(caseId).add(issueState);
    }

    Set<Id> openCases = new Set<Id>();
    Set<Id> resolvedCases = new Set<Id>();
    
    // Make sure all related issues are closed, if not mark case as open
    for ( Id caseId : caseStatuses.keySet() ) {
		List<String> statuses = caseStatuses.get(caseId);
        boolean markOpen = false;
        
        for ( String status : statuses ) {
            if (status == 'Open') {
            	markOpen = true;
                break;
            }
        }
        
        if (markOpen) {
            openCases.add(caseId);
        } else {
            resolvedCases.add(caseId);
        }
    }

    // Bulk update open cases
	for ( Case[] openCasesToUpdate : [SELECT Id, Status FROM Case 
                                      WHERE Id IN :openCases] ) {
		for( Case c : openCasesToUpdate) {
			c.Status = 'Open Issue';
		}
	
		try {	
			update openCasesToUpdate;
		} catch(System.DMLexception e){ 
			for (Integer i = 0; i < e.getNumDml(); i++) { 
				Trigger.new[0].addError('Error updating case statuses: '+e.getDmlMessage(i));
			} 
		}
	}    

    // Bulk update closed cases
	for ( Case[] resolvedCasesToUpdate : [SELECT Id, Status FROM Case 
                             			  WHERE Id IN :resolvedCases] ) {
		for( Case c : resolvedCasesToUpdate) {
			c.Status = 'Resolved Issue';
		}
		
		try {	
			update resolvedCasesToUpdate;
		} catch(System.DMLexception e){ 
			for (Integer i = 0; i < e.getNumDml(); i++) { 
				Trigger.new[0].addError('Error updating case statuses: '+e.getDmlMessage(i));
			} 
		}
	}
}