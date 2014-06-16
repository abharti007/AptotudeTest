public with sharing class SignUpInternal{
  
  public Flow.interview.Sign_Up_Internal flowWizard{get;set;} 
  public String strOppId{get;set;}
  public Opportunity objOpp{get;set;}
  public static final String STR_OPPID = 'varOppId';
  public set<Id> setContactID = new set<Id>();
  public Contact objContact{get;set;}
  
  public SignUpInternal(ApexPages.StandardController stdController) {
    
     strOppId = ApexPages.currentPage().getParameters().get(STR_OPPID);
    

     if(strOppId != Null && strOppId != ''){
        objOpp = [Select Name,ID,o.AccountId,(Select Id, 
        OpportunityId, 
        ContactId,
        Role, 
        IsPrimary 
        From OpportunityContactRoles)
        From Opportunity o 
        Where Id =: strOppId];
     }
     
     for(OpportunityContactRole objContactRole : objOpp.OpportunityContactRoles){
         setContactID.add(objContactRole.ContactId);
     }
     objContact = [Select LastName,FirstName,Email,MailingCountry,Company__c,Phone From Contact where ID IN :setContactID ];
  }
  
  public String getaboutMeID() {
        
        if (flowWizard==null){return '';}
        else{
             return flowWizard.varMeetingId;
        }
    } 
    //Used for Flow finish location
    public PageReference getfinishlocation(){
      
       // PageReference p = new PageReference('/'+getaboutMeID());
       PageReference p = new PageReference('/'+strOppId + '#' + strOppId + '_' + '00NV0000000mRiQ' + '_target');
        p.setRedirect(true);
        return p;
    }
}