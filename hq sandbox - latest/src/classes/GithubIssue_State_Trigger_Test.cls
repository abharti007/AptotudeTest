/**
 * This class contains unit tests for validating the Github_Issue_State_Trigger
 */
@isTest
public class GithubIssue_State_Trigger_Test{

    static Account getTestAccount() {
	    Account acc = new Account(Name='Test Account');
		insert acc;
        return acc;
    }
    
    static Case getTestCase() {
		Case c = new Case(Status='New', Account=getTestAccount(), Origin='Email');
		return c;
    }
	
    static Github_Issue__c getTestIssue(String state, Integer issueNumber) {
        Github_Issue__c i = new Github_Issue__c(Name='Test Issue', State__c=state, Issue_Number__c=issueNumber, Repo_Id__c=123, Repo_Name__c='test/repo', Created_At__c=datetime.now());
        return i;
    }

	static void insertTestCasesAndIssues() {
        List<Account> TestAccounts = new List<Account>();
        List<Case> TestCases = new List<Case>();
        
   		for(Integer i=0; i<200; i++) {
       	    TestAccounts.add(new Account(Name='Test Account'+i));
        }
		insert TestAccounts;
        
		for(Integer i=0; i<200; i++) {
        	TestCases.add(new Case(Subject='Test Case '+i, Status='New', Account=TestAccounts.get(i), Origin='Email'));
        }
		insert TestCases;
        
        List<Github_Issue__c> TestOpenIssues = new List<Github_Issue__c>();
		for(Integer i=0; i<200; i++) {
	        TestOpenIssues.add(new Github_Issue__c(Name='Test Issue'+i, State__c='Open', 
                                                   Issue_Number__c=111 + i, Repo_Id__c=123, 
                                                   Repo_Name__c='test/repo', Created_At__c=datetime.now()));
        }
        insert TestOpenIssues;
        
        List<Github_Issue_Case_Association__c> TestOpenIssueAssociations = 
            new List<Github_Issue_Case_Association__c>();

        Integer i = 0;
		for(Github_Issue__c oghi : TestOpenIssues) {
            TestOpenIssueAssociations.add(new Github_Issue_Case_Association__c(Github_Issue__c = oghi.Id, 
                                                                              Case__c = TestCases.get(i).Id));
			i++;
        }
		insert TestOpenIssueAssociations;
	}
    
    // Test Case for Single Issue
    static testMethod void githubIssueUpdate() {

        Case c = getTestCase();
    	insert c;
	
		Github_Issue__c ghi = getTestIssue('Open', 111);
    	insert ghi;
  	
		Github_Issue_Case_Association__c ica = new Github_Issue_Case_Association__c(Case__c=c.id, Github_Issue__c=ghi.id);
        insert ica;

        test.starttest();
    	// Update the Github Issue State and Verify Case Status is Resolved Issue
		ghi.State__c = 'Closed';
        update ghi;
		
    	Case cTest = [SELECT Status FROM Case];
    	System.AssertEquals(cTest.Status, 'Resolved Issue');
        
		// Reopen the Github Issue State and Verify Case Status is Open Issue     
        ghi.State__c = 'Open';
        update ghi;
        
        Case cTest2 = [SELECT Status FROM Case];
    	System.AssertEquals(cTest2.Status, 'Open Issue');

		// Close the Github Issue and Verify Case Status is Resolved Issue
        ghi.State__c = 'Closed';
        update ghi;
        
        Case cTest3 = [SELECT Status FROM Case];
    	System.AssertEquals(cTest3.Status, 'Resolved Issue');
        
   		test.stoptest();
    }
    
    // Test Case with multiple Issues
    static testMethod void githubIssueUpdateWithMultipleIssues() {

        Case c = getTestCase();
    	insert c;
	
		Github_Issue__c ghi1 = getTestIssue('Open', 111);
    	insert ghi1;

   		Github_Issue__c ghi2 = getTestIssue('Open', 222);
    	insert ghi2;
        
		Github_Issue_Case_Association__c ica1 = new Github_Issue_Case_Association__c(Case__c=c.id, Github_Issue__c=ghi1.id);
        insert ica1;

        Github_Issue_Case_Association__c ica2 = new Github_Issue_Case_Association__c(Case__c=c.id, Github_Issue__c=ghi2.id);
        insert ica2;      

        test.starttest();
    	// Update the Github Issue State and Verify Case Status is Resolved Issue
		ghi1.State__c = 'Closed';
        update ghi1;
		
    	Case cTest = [SELECT Status FROM Case];
    	System.AssertEquals(cTest.Status, 'Resolved Issue');
        
		// Reopen the Github Issue State and Verify Case Status is Open Issue   
        ghi2.State__c = 'Open';
        update ghi2;
        
        Case cTest2 = [SELECT Status FROM Case];
    	System.AssertEquals(cTest2.Status, 'Open Issue');
   		test.stoptest();
    }    
    
    // Test Case with multiple Closed Issues
    static testMethod void githubIssueUpdateWithMultipleClosedIssues() {

        Case c = getTestCase();
    	insert c;
	
		Github_Issue__c ghi1 = getTestIssue('Closed', 111);
    	insert ghi1;

   		Github_Issue__c ghi2 = getTestIssue('Open', 222);
    	insert ghi2;
        
		Github_Issue_Case_Association__c ica1 = new Github_Issue_Case_Association__c(Case__c=c.id, Github_Issue__c=ghi1.id);
        insert ica1;

        Github_Issue_Case_Association__c ica2 = new Github_Issue_Case_Association__c(Case__c=c.id, Github_Issue__c=ghi2.id);
        insert ica2;        

        test.starttest();
    	// Update the Github Issue State and Verify Case Status is Resolved Issue
		ghi2.State__c = 'Closed';
        update ghi1;
		
    	Case cTest = [SELECT Status FROM Case];
    	System.AssertEquals(cTest.Status, 'Resolved Issue');
   		test.stoptest();
    }
	
    /* Commenting out the mass test for production
    // Test mass updating Github Issues
	static testMethod void testMassUpdatingIssues() {
        // Setup 200 cases and open issues
		insertTestCasesAndIssues();

        List<Github_Issue__c> issues = [SELECT Id, State__c FROM Github_Issue__c];

		// Update the Open Issues to Closed
		test.starttest();
        List<Github_Issue__c> openIssues = new List<Github_Issue__c>();
        for(Github_Issue__c i : issues){
            i.State__c = 'Closed';
            openIssues.add(i);
        }
        update openIssues;
		test.stoptest();

		// Query the Cases and verify that the Cases all have a Case Status of Resolved Issue
		List<Case> TestCases = [SELECT Id, Status FROM CASE];

		for(Case c : TestCases) {
   			System.AssertEquals(c.Status, 'Resolved Issue');
		}
    }
	*/
}