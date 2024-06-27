public class AccController {
    @auraEnabled(cacheable=true)
    public static List<Account> getAccList(){
       return [SELECT Id, Name, Phone FROM Account LIMIT 3];
    }
    
    @auraEnabled
    public static list<Account> findAccList(String keyword){
        String key='%'+keyword+'%';
        return[SELECT Id, Name FROM Account WHERE Name Like:key LIMIT 3];
    }

}