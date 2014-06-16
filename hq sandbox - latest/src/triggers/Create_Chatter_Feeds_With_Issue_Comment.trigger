trigger Create_Chatter_Feeds_With_Issue_Comment on Github_Issue_Comment__c (after insert, after update) {
	
	system.debug('====11==='+Userinfo.getUserType());
	system.debug('====22==='+Userinfo.getProfileId());
	
	
    //new Create_Chatter_Feeds_With_Issue_Comment().execute(trigger.new);
}