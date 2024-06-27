//Github webhook secret 
//WSC_XXXXXXXXXXXXXX
@RestResource(urlMapping='/api/Webhooks/pushDetails/*')
global with sharing class GithubWebhookController {
    
    @HttpPost
    global static void handlePost() {
        //request
        RestRequest request = RestContext.request;
        //get body
        Blob requestBody = request.requestBody;
        System.debug('requestBody'+requestBody);
        // Parse JSON data
        JSONParser parser = JSON.createParser(requestBody.toString());
        pusher ps;
        head_commit hc;
        String repo;
        
        while (parser.nextToken() != null) {
            if (parser.getText() == 'pusher') {
                parser.nextToken();
                ps = (pusher)parser.readValueAs(pusher.class);
            } else if (parser.getText() == 'head_commit') {
                parser.nextToken();
                hc = (head_commit)parser.readValueAs(head_commit.class);
            } else if (parser.getText() == 'repository') {
                parser.nextToken();
                repo = parser.getText();
            }
        }

        // Create GitHub_Push_Details__c based on received details
        GitHub_Push_Details__c detail = new GitHub_Push_Details__c();
        detail.Name = (ps != null) ? ps.name : '';
        detail.Committer_Email__c = (ps != null) ? ps.email : '';
        detail.Commit_Message__c = (hc != null) ? hc.message : '';
        detail.Commit_Timestamp__c = (hc != null) ? hc.timestamp : '';
        detail.Committed_URL__c = (hc != null) ? hc.url : '';
        detail.Repository_Name__c = repo;
        detail.Added_Components__c = (hc != null && hc.added != null) ? String.join(hc.added, ',') : '';
        detail.Removed_Components__c = (hc != null && hc.removed != null) ? String.join(hc.removed, ',') : '';
        detail.Modified_Components__c = (hc != null && hc.modified != null) ? String.join(hc.modified, ',') : '';
        
        insert detail;
        System.debug('detail ::@@'+detail);
        
        // Respond with success
        RestResponse response = RestContext.response;
        System.debug('response ----------->@@'+response);
        response.statusCode = 200;
        response.responseBody = Blob.valueOf(JSON.serialize(new SFDCResponse('Success', 'Processed Successfully')));
    }
    
    // Response class
    public class SFDCResponse {
        public String status { get; set; }
        public String message { get; set; }
        public SFDCResponse(String status, String message) {
            this.status = status;
            this.message = message;
        }
    }
    
    // Pusher class
    public class pusher {
        public String name;
        public String email;
    }
    
    // Head commit class
    public class head_commit {
        public String message;
        public String timestamp;
        public String url;
        public List<String> added;
        public List<String> removed;
        public List<String> modified;
    }
}