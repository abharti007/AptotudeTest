@RestResource(urlMapping='/RestChatterFeed/*')
global class CreateChatterFeed {

@HttpPost
    global static void postIssue() { 
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        try {          
            system.debug('req.requestBody.toString()--------------'+req.requestBody.toString());
            
        }
        catch (Exception e) {
            res.responseBody = Blob.valueOf(e.getMessage());
            res.statusCode = 500;
        }
    }

}