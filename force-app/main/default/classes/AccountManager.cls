@RestResource(urlMapping='/Account/*/contacts')
global class AccountManager {
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accId = request.requestURI.substringBetween('Accounts/', '/contacts');
        Account acc =  [SELECT Id,Name,(Select Id, Name FROM Contacts)
                        FROM Account WHERE Id = :accId];
        return acc;
    }
}