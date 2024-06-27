public with sharing class CandidateController {
	@AuraEnabled
    public static Boolean checkCandidateEmail(String email){
        system.debug('email'+email);
        List<Candidate__c> candidateDetails;
        if(
            Schema.sObjectType.Candidate__c.isAccessible() &&
        	Schema.sObjectType.Candidate__c.fields.Id.isAccessible() && 
            Schema.sObjectType.Candidate__c.fields.Email__c.isAccessible()
        ){
            candidateDetails=[select Id From Candidate__c Where Email__c =: email Limit 1]; 
        }
        system.debug('candidateDetails'+candidateDetails);
        if(candidateDetails != null && candidateDetails.size() > 0){
            return false;
        }
        else{
            return true;
        }
    }
    
    @AuraEnabled
    public static void createCandidate(string name,String phone,String email,String role){
            if(
               Schema.sObjectType.Candidate__c.isAccessible() &&
               Schema.sObjectType.Candidate__c.fields.Id.isAccessible() &&
               Schema.sObjectType.Candidate__c.fields.Name.isAccessible() &&
               Schema.sObjectType.Candidate__c.fields.Phone__c.isAccessible() &&
               Schema.sObjectType.Candidate__c.fields.Email__c.isAccessible() &&
               Schema.sObjectType.Candidate__c.fields.Role__c.isAccessible()
            ){
                   try{
                       Candidate__c can = new Candidate__c(
                           Name=name,
                           Email__c=email,
                           Phone__c=phone,
                           Role__c=role
                       );
                       insert can;
                       system.debug('candidate-------->'+can);
                   }
                   Catch(Exception e){
                       system.debug(e.getMessage());
                   }
               }   
        createCandidateInAnother(name,phone,email,role);
    }
       
    @Future(Callout = true)
    Public static void createCandidateInAnother(string name,String phone,String email,String role){
        CalloutController.createCandidateInAnotherOrg(name,phone,email,role);//Create Candidate record in another org.
    }
}