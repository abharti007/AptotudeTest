@isTest
private class GithubIssue_APIResource_Test {

    // JSON string of test data
    static String getValidIssue() {
        String jsonIssue = '{                                                                                                            ' +
            '  \"action\": \"closed\",                                                                                              ' +
            ' \"issue\": {                                                                                                          ' +
            '   \"url\": \"https://api.github.com/repos/aptotude/apto-dev/issues/85\",                                              ' +
            '   \"labels_url\": \"https://api.github.com/repos/aptotude/apto-dev/issues/85/labels{/name}\",                         ' +
            '   \"comments_url\": \"https://api.github.com/repos/aptotude/apto-dev/issues/85/comments\",                            ' +
            '   \"events_url\": \"https://api.github.com/repos/aptotude/apto-dev/issues/85/events\",                                ' +
            '   \"html_url\": \"https://github.com/aptotude/apto-dev/issues/85\",                                                   ' +
            '   \"id\": 35262602,                                                                                                   ' +
            '   \"number\": 85,                                                                                                     ' +
            '   \"title\": \"test issue 9-6-2014\",                                                                                 ' +
            '   \"user\": {                                                                                                         ' +
            '     \"login\": \"HitendraEspl\",                                                                                      ' +
            '     \"id\": 5582952,                                                                                                  ' +
            '     \"avatar_url\": \"https://avatars.githubusercontent.com/u/5582952?\",                                             ' +
            '     \"gravatar_id\": \"4c87fbc5e73b9d3b2e5d4413a79d1ac9\",                                                            ' +
            '     \"url\": \"https://api.github.com/users/HitendraEspl\",                                                           ' +
            '     \"html_url\": \"https://github.com/HitendraEspl\",                                                                ' +
            '     \"followers_url\": \"https://api.github.com/users/HitendraEspl/followers\",                                       ' +
            '     \"following_url\": \"https://api.github.com/users/HitendraEspl/following{/other_user}\",                          ' +
            '     \"gists_url\": \"https://api.github.com/users/HitendraEspl/gists{/gist_id}\",                                     ' +
            '     \"starred_url\": \"https://api.github.com/users/HitendraEspl/starred{/owner}{/repo}\",                            ' +
            '     \"subscriptions_url\": \"https://api.github.com/users/HitendraEspl/subscriptions\",                               ' +
            '     \"organizations_url\": \"https://api.github.com/users/HitendraEspl/orgs\",                                        ' +
            '     \"repos_url\": \"https://api.github.com/users/HitendraEspl/repos\",                                               ' +
            '     \"events_url\": \"https://api.github.com/users/HitendraEspl/events{/privacy}\",                                   ' +
            '     \"received_events_url\": \"https://api.github.com/users/HitendraEspl/received_events\",                           ' +
            '     \"type\": \"User\",                                                                                               ' +
            '     \"site_admin\": false                                                                                             ' +
            '   },                                                                                                                  ' +
            '   \"state\": \"open\",                                                                                                ' +
            '   \"assignee\": {                                                                                                     ' +
            '     \"login\": \"HitendraEspl\",                                                                                      ' +
            '     \"id\": 5582952,                                                                                                  ' +
            '     \"avatar_url\": \"https://avatars.githubusercontent.com/u/5582952?\",                                             ' +
            '     \"gravatar_id\": \"4c87fbc5e73b9d3b2e5d4413a79d1ac9\",                                                            ' +
            '     \"url\": \"https://api.github.com/users/HitendraEspl\",                                                           ' +
            '     \"html_url\": \"https://github.com/HitendraEspl\",                                                                ' +
            '     \"followers_url\": \"https://api.github.com/users/HitendraEspl/followers\",                                       ' +
            '     \"following_url\": \"https://api.github.com/users/HitendraEspl/following{/other_user}\",                          ' +
            '     \"gists_url\": \"https://api.github.com/users/HitendraEspl/gists{/gist_id}\",                                     ' +
            '     \"starred_url\": \"https://api.github.com/users/HitendraEspl/starred{/owner}{/repo}\",                            ' +
            '     \"subscriptions_url\": \"https://api.github.com/users/HitendraEspl/subscriptions\",                               ' +
            '     \"organizations_url\": \"https://api.github.com/users/HitendraEspl/orgs\",                                        ' +
            '     \"repos_url\": \"https://api.github.com/users/HitendraEspl/repos\",                                               ' +
            '     \"events_url\": \"https://api.github.com/users/HitendraEspl/events{/privacy}\",                                   ' +
            '     \"received_events_url\": \"https://api.github.com/users/HitendraEspl/received_events\",                           ' +
            '     \"type\": \"User\",                                                                                               ' +
            '     \"site_admin\": false                                                                                             ' +
            '   },                                                                                                                  ' +
            '   \"milestone\": {                                                                                                    ' +
            '     \"url\": \"https://api.github.com/repos/aptotude/apto-dev/milestones/10\",                                        ' +
            '     \"labels_url\": \"https://api.github.com/repos/aptotude/apto-dev/milestones/10/labels\",                          ' +
            '     \"id\": 686943,                                                                                                   ' +
            '     \"number\": 10,                                                                                                   ' +
            '     \"title\": \"Test Milestone 2\",                                                                                  ' +
            '     \"description\": null,                                                                                            ' +
            '     \"creator\": {                                                                                                    ' +
            '       \"login\": \"thepaulfox\",                                                                                      ' +
            '       \"id\": 31291,                                                                                                  ' +
            '       \"avatar_url\": \"https://avatars.githubusercontent.com/u/31291?\",                                             ' +
            '       \"gravatar_id\": \"7319b2c8f568e2bfb7f5d43b6bcc677d\",                                                          ' +
            '       \"url\": \"https://api.github.com/users/thepaulfox\",                                                           ' +
            '       \"html_url\": \"https://github.com/thepaulfox\",                                                                ' +
            '       \"followers_url\": \"https://api.github.com/users/thepaulfox/followers\",                                       ' +
            '       \"following_url\": \"https://api.github.com/users/thepaulfox/following{/other_user}\",                          ' +
            '       \"gists_url\": \"https://api.github.com/users/thepaulfox/gists{/gist_id}\",                                     ' +
            '       \"starred_url\": \"https://api.github.com/users/thepaulfox/starred{/owner}{/repo}\",                            ' +
            '       \"subscriptions_url\": \"https://api.github.com/users/thepaulfox/subscriptions\",                               ' +
            '       \"organizations_url\": \"https://api.github.com/users/thepaulfox/orgs\",                                        ' +
            '       \"repos_url\": \"https://api.github.com/users/thepaulfox/repos\",                                               ' +
            '       \"events_url\": \"https://api.github.com/users/thepaulfox/events{/privacy}\",                                   ' +
            '       \"received_events_url\": \"https://api.github.com/users/thepaulfox/received_events\",                           ' +
            '       \"type\": \"User\",                                                                                             ' +
            '       \"site_admin\": false                                                                                           ' +
            '     },                                                                                                                ' +
            '     \"open_issues\": 1,                                                                                               ' +
            '     \"closed_issues\": 0,                                                                                             ' +
            '     \"state\": \"open\",                                                                                              ' +
            '     \"created_at\": \"2014-06-10T14:31:29Z\",                                                                         ' +
            '     \"updated_at\": \"2014-06-10T14:31:29Z\",                                                                         ' +
            '     \"due_on\": null                                                                                                  ' +
            '   },                                                                                                                  ' +
            '   \"comments\": 4,                                                                                                    ' +
            '   \"created_at\": \"2014-06-09T06:15:57Z\",                                                                           ' +
            '   \"updated_at\": \"2014-06-11T10:14:57Z\",                                                                           ' +
            '   \"closed_at\": \"2014-06-20T23:19:18Z\",                                                                                                ' +
            '   \"body\": \"body for test issue 9-6-2014\"                                                                          ' +
            '  },                                                                                                                   ' +
            '  \"comment\": {                                                                                                       ' +
            '   \"url\": \"https://api.github.com/repos/aptotude/apto-dev/issues/comments/45724058\",                               ' +
            '   \"html_url\": \"https://github.com/aptotude/apto-dev/issues/85#issuecomment-45724058\",                             ' +
            '   \"issue_url\": \"https://api.github.com/repos/aptotude/apto-dev/issues/85\",                                        ' +
            '   \"id\": 45724058,                                                                                                   ' +
            '   \"user\": {                                                                                                         ' +
            '     \"login\": \"HitendraEspl\",                                                                                      ' +
            '     \"id\": 5582952,                                                                                                  ' +
            '     \"avatar_url\": \"https://avatars.githubusercontent.com/u/5582952?\",                                             ' +
            '     \"gravatar_id\": \"4c87fbc5e73b9d3b2e5d4413a79d1ac9\",                                                            ' +
            '     \"url\": \"https://api.github.com/users/HitendraEspl\",                                                           ' +
            '     \"html_url\": \"https://github.com/HitendraEspl\",                                                                ' +
            '     \"followers_url\": \"https://api.github.com/users/HitendraEspl/followers\",                                       ' +
            '     \"following_url\": \"https://api.github.com/users/HitendraEspl/following{/other_user}\",                          ' +
            '     \"gists_url\": \"https://api.github.com/users/HitendraEspl/gists{/gist_id}\",                                     ' +
            '     \"starred_url\": \"https://api.github.com/users/HitendraEspl/starred{/owner}{/repo}\",                            ' +
            '     \"subscriptions_url\": \"https://api.github.com/users/HitendraEspl/subscriptions\",                               ' +
            '     \"organizations_url\": \"https://api.github.com/users/HitendraEspl/orgs\",                                        ' +
            '     \"repos_url\": \"https://api.github.com/users/HitendraEspl/repos\",                                               ' +
            '     \"events_url\": \"https://api.github.com/users/HitendraEspl/events{/privacy}\",                                   ' +
            '     \"received_events_url\": \"https://api.github.com/users/HitendraEspl/received_events\",                           ' +
            '     \"type\": \"User\",                                                                                               ' +
            '     \"site_admin\": false                                                                                             ' +
            '   },                                                                                                                  ' +
            '   \"created_at\": \"2014-06-11T10:14:57Z\",                                                                           ' +
            '   \"updated_at\": \"2014-06-11T10:14:57Z\",                                                                           ' +
            '   \"body\": \"Testing milestone 2 comment\"                                                                           ' +
            '  },                                                                                                                   ' +
            '  \"repository\": {                                                                                                    ' +
            '   \"id\": 17033954,                                                                                                   ' +
            '   \"name\": \"apto-dev\",                                                                                             ' +
            '   \"full_name\": \"aptotude/apto-dev\",                                                                               ' +
            '   \"owner\": {                                                                                                        ' +
            '     \"login\": \"aptotude\",                                                                                          ' +
            '     \"id\": 6415404,                                                                                                  ' +
            '     \"avatar_url\": \"https://avatars.githubusercontent.com/u/6415404?\",                                             ' +
            '     \"gravatar_id\": \"e7772080beacc12b52192de29e783147\",                                                            ' +
            '     \"url\": \"https://api.github.com/users/aptotude\",                                                               ' +
            '     \"html_url\": \"https://github.com/aptotude\",                                                                    ' +
            '     \"followers_url\": \"https://api.github.com/users/aptotude/followers\",                                           ' +
            '     \"following_url\": \"https://api.github.com/users/aptotude/following{/other_user}\",                              ' +
            '     \"gists_url\": \"https://api.github.com/users/aptotude/gists{/gist_id}\",                                         ' +
            '     \"starred_url\": \"https://api.github.com/users/aptotude/starred{/owner}{/repo}\",                                ' +
            '     \"subscriptions_url\": \"https://api.github.com/users/aptotude/subscriptions\",                                   ' +
            '     \"organizations_url\": \"https://api.github.com/users/aptotude/orgs\",                                            ' +
            '     \"repos_url\": \"https://api.github.com/users/aptotude/repos\",                                                   ' +
            '     \"events_url\": \"https://api.github.com/users/aptotude/events{/privacy}\",                                       ' +
            '     \"received_events_url\": \"https://api.github.com/users/aptotude/received_events\",                               ' +
            '     \"type\": \"Organization\",                                                                                       ' +
            '     \"site_admin\": false                                                                                             ' +
            '   },                                                                                                                  ' +
            '   \"private\": true,                                                                                                  ' +
            '   \"html_url\": \"https://github.com/aptotude/apto-dev\",                                                             ' +
            '   \"description\": \"This project tracks the dev version of the apto managed package\",                               ' +
            '   \"fork\": false,                                                                                                    ' +
            '   \"url\": \"https://api.github.com/repos/aptotude/apto-dev\",                                                        ' +
            '   \"forks_url\": \"https://api.github.com/repos/aptotude/apto-dev/forks\",                                            ' +
            '   \"keys_url\": \"https://api.github.com/repos/aptotude/apto-dev/keys{/key_id}\",                                     ' +
            '   \"collaborators_url\": \"https://api.github.com/repos/aptotude/apto-dev/collaborators{/collaborator}\",             ' +
            '   \"teams_url\": \"https://api.github.com/repos/aptotude/apto-dev/teams\",                                            ' +
            '   \"hooks_url\": \"https://api.github.com/repos/aptotude/apto-dev/hooks\",                                            ' +
            '   \"issue_events_url\": \"https://api.github.com/repos/aptotude/apto-dev/issues/events{/number}\",                    ' +
            '   \"events_url\": \"https://api.github.com/repos/aptotude/apto-dev/events\",                                          ' +
            '   \"assignees_url\": \"https://api.github.com/repos/aptotude/apto-dev/assignees{/user}\",                             ' +
            '   \"branches_url\": \"https://api.github.com/repos/aptotude/apto-dev/branches{/branch}\",                             ' +
            '   \"tags_url\": \"https://api.github.com/repos/aptotude/apto-dev/tags\",                                              ' +
            '   \"blobs_url\": \"https://api.github.com/repos/aptotude/apto-dev/git/blobs{/sha}\",                                  ' +
            '   \"git_tags_url\": \"https://api.github.com/repos/aptotude/apto-dev/git/tags{/sha}\",                                ' +
            '   \"git_refs_url\": \"https://api.github.com/repos/aptotude/apto-dev/git/refs{/sha}\",                                ' +
            '   \"trees_url\": \"https://api.github.com/repos/aptotude/apto-dev/git/trees{/sha}\",                                  ' +
            '   \"statuses_url\": \"https://api.github.com/repos/aptotude/apto-dev/statuses/{sha}\",                                ' +
            '   \"languages_url\": \"https://api.github.com/repos/aptotude/apto-dev/languages\",                                    ' +
            '   \"stargazers_url\": \"https://api.github.com/repos/aptotude/apto-dev/stargazers\",                                  ' +
            '   \"contributors_url\": \"https://api.github.com/repos/aptotude/apto-dev/contributors\",                              ' +
            '   \"subscribers_url\": \"https://api.github.com/repos/aptotude/apto-dev/subscribers\",                                ' +
            '   \"subscription_url\": \"https://api.github.com/repos/aptotude/apto-dev/subscription\",                              ' +
            '   \"commits_url\": \"https://api.github.com/repos/aptotude/apto-dev/commits{/sha}\",                                  ' +
            '   \"git_commits_url\": \"https://api.github.com/repos/aptotude/apto-dev/git/commits{/sha}\",                          ' +
            '   \"comments_url\": \"https://api.github.com/repos/aptotude/apto-dev/comments{/number}\",                             ' +
            '   \"issue_comment_url\": \"https://api.github.com/repos/aptotude/apto-dev/issues/comments/{number}\",                 ' +
            '   \"contents_url\": \"https://api.github.com/repos/aptotude/apto-dev/contents/{+path}\",                              ' +
            '   \"compare_url\": \"https://api.github.com/repos/aptotude/apto-dev/compare/{base}...{head}\",                        ' +
            '   \"merges_url\": \"https://api.github.com/repos/aptotude/apto-dev/merges\",                                          ' +
            '   \"archive_url\": \"https://api.github.com/repos/aptotude/apto-dev/{archive_format}{/ref}\",                         ' +
            '   \"downloads_url\": \"https://api.github.com/repos/aptotude/apto-dev/downloads\",                                    ' +
            '   \"issues_url\": \"https://api.github.com/repos/aptotude/apto-dev/issues{/number}\",                                 ' +
            '   \"pulls_url\": \"https://api.github.com/repos/aptotude/apto-dev/pulls{/number}\",                                   ' +
            '   \"milestones_url\": \"https://api.github.com/repos/aptotude/apto-dev/milestones{/number}\",                         ' +
            '   \"notifications_url\": \"https://api.github.com/repos/aptotude/apto-dev/notifications{?since,all,participating}\",  ' +
            '   \"labels_url\": \"https://api.github.com/repos/aptotude/apto-dev/labels{/name}\",                                   '  +
            '   \"releases_url\": \"https://api.github.com/repos/aptotude/apto-dev/releases{/id}\",                                 '  +
            '   \"created_at\": \"2014-02-20T20:11:28Z\",                                                                           '  +
            '   \"updated_at\": \"2014-06-10T21:06:09Z\",                                                                           '  +
            '   \"pushed_at\": \"2014-06-10T21:06:12Z\",                                                                            '  +
            '   \"git_url\": \"git://github.com/aptotude/apto-dev.git\",                                                            '  +
            '   \"ssh_url\": \"git@github.com:aptotude/apto-dev.git\",                                                              '  +
            '   \"clone_url\": \"https://github.com/aptotude/apto-dev.git\",                                                        '  +
            '   \"svn_url\": \"https://github.com/aptotude/apto-dev\",                                                              '  +
            '   \"homepage\": null,                                                                                                 '  +
            '   \"size\": 7019,                                                                                                     '  +
            '   \"stargazers_count\": 0,                                                                                            '  +
            '   \"watchers_count\": 0,                                                                                              '  +
            '   \"language\": \"Apex\",                                                                                             '  +
            '   \"has_issues\": true,                                                                                               '  +
            '   \"has_downloads\": true,                                                                                            '  +
            '   \"has_wiki\": true,                                                                                                 '  +
            '   \"forks_count\": 1,                                                                                                 '  +
            '   \"mirror_url\": null,                                                                                               '  +
            '   \"open_issues_count\": 14,                                                                                          '  +
            '   \"forks\": 1,                                                                                                       '  +
            '   \"open_issues\": 14,                                                                                                '  +
            '   \"watchers\": 0,                                                                                                    '  +
            '   \"default_branch\": \"master\"                                                                                      '  +
            ' },                                                                                                                    '  +
            ' \"sender\": {                                                                                                         '  +
            '   \"login\": \"HitendraEspl\",                                                                                        '  +
            '   \"id\": 5582952,                                                                                                    '  +
            '   \"avatar_url\": \"https://avatars.githubusercontent.com/u/5582952?\",                                               '  +
            '   \"gravatar_id\": \"4c87fbc5e73b9d3b2e5d4413a79d1ac9\",                                                              '  +
            '   \"url\": \"https://api.github.com/users/HitendraEspl\",                                                             '  +
            '   \"html_url\": \"https://github.com/HitendraEspl\",                                                                  '  +
            '   \"followers_url\": \"https://api.github.com/users/HitendraEspl/followers\",                                         '  +
            '   \"following_url\": \"https://api.github.com/users/HitendraEspl/following{/other_user}\",                            '  +
            '   \"gists_url\": \"https://api.github.com/users/HitendraEspl/gists{/gist_id}\",                                       '  +
            '   \"starred_url\": \"https://api.github.com/users/HitendraEspl/starred{/owner}{/repo}\",                              '  +
            '   \"subscriptions_url\": \"https://api.github.com/users/HitendraEspl/subscriptions\",                                 '  +
            '   \"organizations_url\": \"https://api.github.com/users/HitendraEspl/orgs\",                                          '  +
            '   \"repos_url\": \"https://api.github.com/users/HitendraEspl/repos\",                                                 '  +
            '   \"events_url\": \"https://api.github.com/users/HitendraEspl/events{/privacy}\",                                     '  +
            '   \"received_events_url\": \"https://api.github.com/users/HitendraEspl/received_events\",                             '  +
            '   \"type\": \"User\",                                                                                                 '  +
            '   \"site_admin\": false                                                                                               '  +
            ' }                                                                                                                     '  +
            '}';      
        return jsonIssue;
    }
    
    // Set the Request
    static RestResponse setRequest(String body) {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/github/*';
        req.httpMethod = 'POST';            
        req.requestBody = Blob.valueOf(body);
        RestContext.request = req; 
        RestContext.response= res; 
        return res;
    }
    
    // Test for Successful Response with valid issue
    static testMethod void testRestService() {
		
        RestResponse response = setRequest(getValidIssue());
        GithubIssue_APIResource.postIssue();

        // Verify the successful response StatusCode
        System.assertEquals(response.statusCode, 200);
        
        // Verify the issue was created
        System.assertEquals(GithubIssue.issueExists(1234, 5678), True);
	}

    // Test for Failed Response with an invalid isssue
    static testMethod void testRestService2() {
		
		RestResponse response = setRequest('');           
        GithubIssue_APIResource.postIssue();
        
        // Verify the failed response StatusCode
        System.assertEquals(response.statusCode, 500);
	}    
}