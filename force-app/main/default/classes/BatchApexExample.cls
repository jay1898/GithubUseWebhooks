/*Start Method*/
global class BatchApexExample implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC){
        string query = 'SELECT Id,Name FROM Account';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC,List<Account> accList){
        for(Account acc: accList){
            acc.Name = acc.Name + 'Chanakya Training';
        }
        try{
            update accList;
        }catch(Exception e){
            system.debug(e);
        }
    }
    global void finish(Database.BatchableContext BC){
        
    }
    
}