@isTest
private class GitHubIssue_Test {
    static GithubIssue getTestIssue(Decimal i_id, String i_state) {
        GithubIssue i = new GithubIssue();
        i.Name = 'Test Issue';
        i.body = 'Test Issue body';        
        i.created_at = datetime.valueOf('2011-12-12 23:19:18');
        i.updated_at = datetime.valueOf('2013-01-01 23:19:18');
        i.issueNumber = i_id;
        i.state = i_state;
        i.url = 'https://api.github.com/repos/efortenberry/test_repo/issues/' + i_id;
        i.repoName = 'efortenberry/test_repo';
        i.repoId = 1;
        return i;
    }

    // Test the createIssue and findIssue methods
    static testMethod void createIssueTest() {

        // Test creating issue
        GithubIssue i = getTestIssue(1, 'Open');
        GithubIssue.createIssue(i);
        
        // Verify the issues was created using the findIssue method
        System.assertEquals(GithubIssue.findIssue(i.issueNumber, i.repoId).Description__c, i.body);
        System.assertEquals(GithubIssue.findIssue(i.issueNumber, i.repoId).Repo_Name__c, i.repoName);
    }
    
    // Test the issueExists method
    static testMethod void issueExistsTest() {
        
        // Create issue
        GithubIssue i = getTestIssue(2, 'Open');
        GithubIssue.createIssue(i);

        // Verify issue exists using issueExists method
        System.assertEquals(GithubIssue.issueExists(i.issueNumber, i.repoId), True);
    }
            
    // Test the updateIssue method
    static testMethod void updateIssueTest() {

        // Create an issue
        GithubIssue i = getTestIssue(3, 'Open');
        GithubIssue.createIssue(i);
                            
        //Test updating the issue
        GithubIssue gi = getTestIssue(3, 'Closed');
        GithubIssue.updateIssue(gi);

        // Verify the updates were saved
        System.assertEquals(GithubIssue.findIssue(i.issueNumber, i.repoId).State__c, 'Closed');
        System.assertEquals(GithubIssue.findIssue(gi.issueNumber, gi.repoId).id, GithubIssue.findIssue(i.issueNumber, i.repoId).id);     
    }

    // Test creating and updating issues from JSON using the processIssue method
    static testMethod void processIssueTest() {
        // JSON representation of an issue with an 'open' state
        String json = '{                                                                                                            ' +
            '  \"action\": \"opened\",                                                                                              ' +
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
            '   \"closed_at\": null,                                                                                                ' +
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
            ' }'+
            '}'   ;
    
        
        // Deserialize the json
        Map<String, Object> obj = (Map<String, Object>) System.JSON.deserializeUntyped(json);
        
        // Create issueMap with the 'issue' info
        Map<String, Object> issueMap = (Map<String, Object>) obj.get('issue');
        
        // Add the 'repo' info to the issueMap
        Map<String, Object> repoMap = (Map<String, Object>) obj.get('repository');
        issueMap.put('repo', repoMap);
        
        // Add the 'comment' info to the issueMap
        Map<String, Object> commentMap = (Map<String, Object>) obj.get('comment');
        issueMap.put('comment', commentMap);
        
        // Add the 'milestone' info to the issueMap
        Map<String, Object> milestoneMap = (Map<String, Object>) ((Map<String, Object>) obj.get('issue')).get('milestone');
        issueMap.put('milestone', milestoneMap);
        
        // Test processIssue method by passing it the issueMap
        GithubIssue.processIssue(issueMap);

        // Verify the issue was created
        System.assertEquals(GithubIssue.issueExists(85, 17033954), True);
        System.assertEquals(GithubIssue.issueExists(85, 222), False);
        System.assertEquals(string.valueOf(GithubIssue.findIssue(85, 17033954).Closed_At__c), null);
        
        // Test updating the issue state to closed
        String json2 = '{                                                                                                            ' +
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
    
        
        // Deserialize json and create issueMap
        Map<String, Object> obj2 = (Map<String, Object>) System.JSON.deserializeUntyped(json2);
        
        Map<String, Object> issueMap2 = (Map<String, Object>) obj2.get('issue');
        Map<String, Object> repoMap2 = (Map<String, Object>) obj2.get('repository');
        issueMap2.put('repo', repoMap2);
        
        // Add the 'comment' info to the issueMap
        Map<String, Object> commentMap2 = (Map<String, Object>) obj.get('comment');
        issueMap2.put('comment', commentMap2);
        
        // Add the 'milestone' info to the issueMap
        Map<String, Object> milestoneMap2 = (Map<String, Object>) ((Map<String, Object>) obj.get('issue')).get('milestone');
        issueMap2.put('milestone', milestoneMap2);
        
        // Test updating issue
        GithubIssue.processIssue(issueMap2);
       
        // Verify the issue state was updated from open to close
        System.assertEquals(GithubIssue.issueExists(85, 17033954), True);
        System.assertEquals(GithubIssue.findIssue(85, 17033954).State__c, 'Closed');
        System.assertEquals(string.valueOf(GithubIssue.findIssue(85, 17033954).Closed_At__c), '2014-06-20 23:19:18');
        System.assertEquals(GithubIssue.findIssue(85, 17033954).Repo_Name__c, 'aptotude/apto-dev');
    }
   
}