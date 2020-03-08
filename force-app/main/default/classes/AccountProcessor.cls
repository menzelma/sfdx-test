public class AccountProcessor {
    @future
    public static void countContacts(Set<Id> recordIds){
        List<Account> accounts = [SELECT Id,Number_of_Contacts__c, (SELECT Id From Contacts) FROM Account WHERE Id In :recordIds];
        for(Account acc:accounts){
            List<Contact> contactLst = acc.Contacts;
            acc.Number_of_Contacts__c=contactLst.size();
        }
        update accounts;
    }
}