public class GithubIssue {
    
    public String Name;
    public String body;
    public Datetime closed_at;
    public Datetime created_at;
    public Decimal issueNumber;
    public String state;
    public Datetime updated_at;
    public String url;
    public String repoName;
    public Decimal repoId;
    
    public String comments;
    public String githubIssueId;
    
    // Fields for the milestones
    public string milestone_title;
    public Date milestone_due_on;
    public Datetime milestone_created_at;
    public string milestone_state;
    public Decimal milestone_Id;
    public string milestone_Url;
    
    public GithubIssue() {
        comments='';
        
    }
    public GithubIssue(Map<String, Object> m) {
        
        system.debug('inside constructor----');
        this.Name        = (String)  m.get('title');
        this.body        = (String)  m.get('body');
        this.url         = (String)  m.get('html_url');
        this.issueNumber = (Decimal) m.get('number');
        this.state       = (String)  m.get('state');
        this.created_at  = parseDatetime((String) m.get('created_at'));
        this.updated_at  = parseDatetime((String) m.get('updated_at'));
        
        if (m.get('closed_at') != null) {
            this.closed_at = parseDatetime((String) m.get('closed_at'));
        }
        
        this.repoName    = (String) ((Map<String, Object>) m.get('repo')).get('full_name');
        this.repoId      = (Decimal) ((Map<String, Object>) m.get('repo')).get('id');
        
        if(((Map<String, Object>) m.get('comment')) != null)
            this.comments    = (String) ((Map<String, Object>) m.get('comment')).get('body');

        //  Add Milestone details
        this.milestone_title   = (String) ((Map<String, Object>) m.get('milestone')).get('title');
        this.milestone_Id   = (Decimal)((Map<String, Object>) m.get('milestone')).get('id');
        
        if(((Map<String, Object>) m.get('milestone')).get('due_on') !=null)
            this.milestone_due_on   = parseDate((String)((Map<String, Object>) m.get('milestone')).get('due_on'));
        
        this.milestone_created_at   = parseDatetime((String)((Map<String, Object>) m.get('milestone')).get('created_at'));
        this.milestone_state   = (String)((Map<String, Object>) m.get('milestone')).get('state');
        this.milestone_Url   = (String)((Map<String, Object>) m.get('milestone')).get('url');
    }
    
    public static Date parseDate(String dt) {
        Datetime dtm = parseDatetime(dt);
        Date d = dtm.date();
        return d;
    }
    
    public static Datetime parseDatetime(String dt) {
        String s = dt; 
        String str = s.replace('T',' ').replace('Z', '');
        return DateTime.valueOf(str);
    }
    
    public static void processIssue(Map<String, Object> issueMap) {
        GithubIssue issue = new GithubIssue(issueMap);
        // condition to add milestone 
        if (milestoneExists(issue.milestone_Url)){
        	system.debug('inside processIssue if milestone-----');
            updateMilestone(issue);
            
        }
        else{
        	system.debug('inside processIssue else milestone-----');
            createMilestone(issue);
        }

        if (issueExists(issue.issueNumber, issue.repoId)){
            system.debug('inside processIssue if issue-----');
            updateIssue(issue);
        }
        else{
            system.debug('inside processIssue else issue-----');
            createIssue(issue);
        }
    }
    
    
    // code to identify Milestone is exist or not
    
    public static boolean milestoneExists(string githubMilestoneUrl) {
        if (findMilestone(githubMilestoneUrl) != null) {
            return True;
        } else {
            return False;
        }
    } 
    
    public static GitHub_Milestones__c findMilestone(string githubMilestoneUrl ) {
        GitHub_Milestones__c milestone = null;
        List<GitHub_Milestones__c> milestones = [Select g.URL__c, 
                                                        g.State__c, 
                                                        g.Name, 
                                                        g.Milestone_Id__c, 
                                                        g.Id, 
                                                        g.Due_On__c 
                                                 From GitHub_Milestones__c g Where g.URL__c =: githubMilestoneUrl LIMIT 1];
        if(milestones.size() > 0) {
            return milestones.get(0);
        } else {
            return milestone;
        }
    }
    
    
    // code to identify issue is exist or not
    public static boolean issueExists(Decimal issueNumber, Decimal repoId) {
        if (findIssue(issueNumber, repoId) != null) {
            return True;
        } else {
            return False;
        }
    } 
    
    public static Github_Issue__c findIssue(Decimal issueNumber, Decimal repoId) {
        Github_Issue__c issue = null;
        List<Github_Issue__c> issues = [SELECT Id, 
                                               Name, 
                                               Description__c, 
                                               Github_URL__c, 
                                               Issue_Number__c, 
                                               State__c, 
                                               Created_At__c, 
                                               Updated_At__c, 
                                               Closed_At__c, 
                                               Repo_Name__c, 
                                               Repo_Id__c, 
                                               Comments__c
                                         FROM Github_Issue__c 
                                         WHERE Issue_Number__c = :issueNumber AND Repo_Id__c = :repoId LIMIT 1];
        if(issues.size() > 0) {
            return issues.get(0);
        } else {
            return issue;
        }
    }

    //Method to create Milestone
    public static void createMilestone(GithubIssue issue) {
        
        system.debug('inside createMilestone----------');// 
        GitHub_Milestones__c newGitHubMilestones = new GitHub_Milestones__c();
            
            newGitHubMilestones.URL__c           = issue.milestone_Url;
            newGitHubMilestones.Name             = issue.milestone_title;
            newGitHubMilestones.Milestone_Id__c  = issue.milestone_Id;
            newGitHubMilestones.Due_On__c        = issue.milestone_due_on;
            newGitHubMilestones.State__c         = issue.milestone_state;
            
            //newGitHubMilestones.Release__c       = ;
            
        insert newGitHubMilestones;
        
    }

    //Method to create Issue 
    public static void createIssue(GithubIssue issue) {
        system.debug('inside createIssue----------');
        GitHub_Milestones__c m = findMilestone(issue.milestone_Url);
        
        Github_Issue__c newIssue = new Github_Issue__c();
            newIssue.Name               = issue.Name;
            newIssue.Description__c     = issue.body;
            newIssue.Github_URL__c      = issue.url;
            newIssue.Issue_Number__c    = issue.issueNumber;
            newIssue.State__c           = issue.state;
            newIssue.Created_At__c      = issue.created_at;
            newIssue.Updated_At__c      = issue.updated_at;
            newIssue.Closed_At__c       = issue.closed_at;
            newIssue.Repo_Name__c       = issue.repoName;
            newIssue.Repo_Id__c         = issue.repoId;
            newIssue.Comments__c        = issue.comments;
            
            if(m!=null){
                newIssue.GitHub_Milestone__c=m.Id;
            }
        insert newIssue;
        
    }
    
    //Method to Update Milestone
    public static void updateMilestone(GithubIssue issue) {
    	system.debug('inside update Milestone----------');
        GitHub_Milestones__c m = findMilestone(issue.milestone_Url);
            m.URL__c           = issue.milestone_Url;
            m.Name             = issue.milestone_title;
            m.Milestone_Id__c  = issue.milestone_Id;
            m.Due_On__c        = issue.milestone_due_on;
            m.State__c         = issue.milestone_state;
        update m;
        
    }

    //Method to Update Issue 
    public static void updateIssue(GithubIssue issue) {
    	system.debug('inside updateIssue----------');
        GitHub_Milestones__c m = findMilestone(issue.milestone_Url);
        
        system.debug('inside updateIssue------milestone----'+m);
        
        Github_Issue__c i = findIssue(issue.issueNumber, issue.RepoId);
        i.Name            = issue.Name;
        i.Description__c  = issue.body;
        i.Github_URL__c   = issue.url;
        i.Issue_Number__c = issue.issueNumber;
        i.State__c        = issue.state;
        i.Created_At__c   = issue.created_at;
        i.Updated_At__c   = issue.updated_at;
        i.Closed_At__c    = issue.closed_at;
        i.Repo_Name__c    = issue.repoName;
        i.Repo_Id__c      = issue.repoId;
        
        if(issue.comments!='')
            i.Comments__c     = issue.comments;
            
        if(m!=null)
                i.GitHub_Milestone__c=m.Id;
                
        update i;
        
        if(i.Comments__c !='' && i.Comments__c != null){
            Github_Issue_Comment__c issueComment = new Github_Issue_Comment__c();
            issueComment.Github_Issue__c    = i.Id;
            issueComment.Comment_Body__c    = i.Comments__c;
            issueComment.FeedItem_Title__c  = i.Description__c;
            insert issueComment;
            system.debug('===issueComment===='+issueComment);
            
        }
    }
}