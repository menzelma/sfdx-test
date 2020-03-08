@RestResource(urlMapping='/Account/*')
global with sharing class AccountWithOpportunityEndpoint {

    @HttpGet
    global static String getAccountsWithOpportunities() {
        List<Account> accountsWithOpportunities = [SELECT Id, (SELECT Id FROM Opportunities LIMIT 10) FROM Account LIMIT 50];
        return JSON.serialize(accountsWithOpportunities);
    }

}