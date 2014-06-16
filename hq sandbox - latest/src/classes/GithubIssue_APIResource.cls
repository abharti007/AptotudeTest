// The endpoint is: https://sandbox-orgsync.cs3.force.com/services/apexrest/github
@RestResource(urlMapping='/github/*') 
global class GithubIssue_APIResource {
    
    @HttpPost
    global static void postIssue() { 
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        try {    
        	system.debug('req.requestBody.toString()--------------'+req.requestBody.toString());      
            Map<String, Object> body = (Map<String, Object>) System.JSON.deserializeUntyped(req.requestBody.toString());
            
            system.debug('body----------'+body);
            Map<String, Object> issueMap = (Map<String, Object>) body.get('issue');
            Map<String, Object> repoMap = (Map<String, Object>) body.get('repository');
            Map<String, Object> commentMap = (Map<String, Object>) body.get('comment');
            Map<String, Object> milstoneMap = (Map<String, Object>) ((Map<String, Object>) body.get('issue')).get('milestone');
            
            issueMap.put('repo', repoMap);
            issueMap.put('comment', commentMap);
            issueMap.put('milestone', milstoneMap);
            
            system.debug('repoMap----------'+repoMap);
            system.debug('commentMap----------'+commentMap);
            system.debug('milstoneMap----------'+milstoneMap);
            system.debug('issueMap----------'+issueMap);
            
            
            GithubIssue.processIssue(issueMap);            
            res.statusCode = 200;
        }
        catch (Exception e) {
            res.responseBody = Blob.valueOf(e.getMessage());
            res.statusCode = 500;
        }
    }
}