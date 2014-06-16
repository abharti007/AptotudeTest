public without sharing class Create_Chatter_Feeds_With_Issue_Comment {
    public list<FeedItem> listFeedItems; 
    public list<FeedComment> listFeedComment;
    
    public Create_Chatter_Feeds_With_Issue_Comment (){
        system.debug('inside trigger controller constructor---------');
        listFeedItems = new list<FeedItem>();
        listFeedComment = new list<FeedComment>();
    }
    
    /*public void execute(list<Github_Issue_Comment__c> listIssueComment){
        system.debug('listIssueComment=========='+listIssueComment);
        list<Id> listGithubIssueCommId = new list<Id>();
        list<Github_Issue_Comment__c> listOfAllCommentsForIssue = new list<Github_Issue_Comment__c>();
        for(Github_Issue_Comment__c issue:listIssueComment){
            listGithubIssueCommId.add(issue.Id);
        }
        
        system.debug('listGithubIssueCommId----'+listGithubIssueCommId);
        map<Id, Github_Issue_Comment__c> mapIssueComment = new map<Id, Github_Issue_Comment__c>();
        
        if(listGithubIssueCommId != null && listGithubIssueCommId.size()>0){
            for(Github_Issue_Comment__c gitIssueComm : [Select g.updated_at__c, g.created_at__c, g.FeedItem_Title__c, g.SystemModstamp, g.OwnerId, g.Name, g.Id, g.Github_Issue__c, g.Comment_Id__c, g.Comment_Body__c From Github_Issue_Comment__c g Where g.Id IN : listGithubIssueCommId]){
                 listOfAllCommentsForIssue.add(gitIssueComm);
            }
        
        }
        
        Http h1 = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Authorization', 'OAuth ' + Userinfo.getSessionId());
        req.setHeader('accept','application/json');
        
        
        if(listIssueComment != null && listIssueComment.size()>0){
        	req.setEndpoint( 'https://ap1.salesforce.com/services/data/v30.0/chatter/feeds/user-profile/'+listIssueComment[0].OwnerId+'/feed-items');
        }
        
            /*FeedItem githubIssueFeed = new FeedItem();
            //githubIssueFeed.CreatedById = Userinfo.getUserId();
            githubIssueFeed.ParentId = listIssueComment[0].Id; //Github_Issue__c Id
            githubIssueFeed.Body = gitIssueComm.FeedItem_Title__c;*/
            
            
            /*FeedComment fcomment = new FeedComment();
            //fcomment.FeedItemId = fItems.Id; //Id of the FeedItem on which you want to comment
            fcomment.CommentBody = listIssueComment[0].Comment_Body__c;
        
        //req.setEndpoint( 'https://ap1.salesforce.com/services/data/v30.0/chatter/feeds/user-profile/me/feed-items');
        req.setBody( JSON.serialize(fcomment) );
        System.debug( '##### Serialized list of sapaccounts into JSON format: ' + req.getBody() );
        HttpResponse res1 = h1.send(req);
        system.debug('req--------------'+res1);
        
        
    }*/
}