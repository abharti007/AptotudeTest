public class ContactRoleVFPController {
	public Opportunity opp {get;set;}
	public List<ContactRoleModel> contactRoles {get;set;}
	public integer primaryContactId {get;set;}
	
	
	public ContactRoleVFPController(ApexPages.standardController stdCon){
		opp = [Select id, Accountid from Opportunity where id =:stdCon.getId()];
		contactRoles = new List<ContactRoleModel>();			
		primaryContactId = contactRoles.size()+1;	
		contactRoles.add(new ContactRoleModel(null, contactRoles.size()+1));	
		Set<Id> contactIds = new Set<Id>();	
		for(OpportunityContactRole ocr : [Select id, ContactId, OpportunityId ,isPrimary, Role 
						from OpportunityContactRole 
						where opportunityId =:opp.id]){
			if(ocr.IsPrimary == true){
				primaryContactId = contactRoles.size()+1;
			}
			contactRoles.add(new ContactRoleModel(ocr, contactRoles.size()+1));
			contactIds.add(ocr.ContactId);
		}
		
		for(Contact c : [Select id from Contact where accountid =:opp.Accountid and Id not in :contactIds]){
			contactRoles.add(new ContactRoleModel(new OpportunityContactRole(ContactId = c.id, OpportunityId = opp.id), contactRoles.size()+1));
		}
		
		for(Integer i =contactRoles.size()  ;i<=4 ; i++){
			contactRoles.add(new ContactRoleModel(new OpportunityContactRole(), contactRoles.size()+1));
		}
		
		
	}
	
	public Pagereference save(){
		List<OpportunityContactRole> rolesToDelete = new List<OpportunityContactRole>();
		List<OpportunityContactRole> rolesToupsert = new List<OpportunityContactRole>();
		opp.Billing_Contact__c = null;
		for(ContactRoleModel crm : contactRoles){
			if(crm.ocr != null){
				
				if(crm.ocr.Role != null && crm.ocr.ContactId != null){
					rolesToupsert.add(crm.ocr);
					if(crm.ocr.id == null){
						crm.ocr.OpportunityId = opp.id;
					}
					if(crm.idx == primaryContactId){
						crm.ocr.isPrimary = true;
						opp.Billing_Contact__c = crm.ocr.ContactId;
					}else{
						crm.ocr.isPrimary = false;
					}					
				}else if(crm.ocr.id != null){
					rolesToDelete.add(crm.ocr);
				}
			}
		}
		delete rolesToDelete;
		upsert rolesToupsert;
		update opp;
		return new Pagereference('/' + opp.id);
	}
	
	public class ContactRoleModel{
		public Boolean showField {
			get {
				return ocr != null;
			}
		}
		public integer idx {get;set;}
		public OpportunityContactRole ocr {get;set;}
		
		public ContactRoleModel(OpportunityContactRole ocr,integer idx){
			this.ocr = ocr;
			this.idx = idx;
		}
	}
	
	@isTest
	private static void testOpp(){
		Account a = new Account(Name = 'test');
		insert a;
		Contact c = new Contact(AccountId = a.id, FirstName = 'test', Email='test@test.com', LastName = 'test');
		insert c;
		Opportunity o = new Opportunity();
		o.Accountid = a.id;
		o.CloseDate = Date.Today();
		o.StageName = 'No Trial';
		o.Name = 'test';
		insert o;
		
		ContactRoleVFPController conVFP = new ContactRoleVFPController(new Apexpages.Standardcontroller(o));
		conVFP.contactRoles[1].ocr.contactId = c.id;
		conVFP.contactRoles[1].ocr.Role = 'Business User';
		conVFP.primaryContactId = 2;
		conVFP.save();
	}

}