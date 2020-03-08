@isTest
public class AddPrimaryContactTest {
    @isTest
     static void testPrimaryContacts(){
        List<Account> testAccs = new List<Account>();
    
    	for(Integer i=0;i<50;i++){
        	testAccs.add(new Account(Name='AccountNY'+i,BillingState='NY'));
    	}
    	for(Integer i=0;i<50;i++){
       	 	testAccs.add(new Account(Name='AccountCA'+i,BillingState='CA'));
   	 	}
        insert testAccs;
         
        Contact co = new Contact();
        co.FirstName='testtest';
        co.LastName='testtest';
        insert co;
        String state='CA';
         
        AddPrimaryContact apc = new AddPrimaryContact(co,state);
        Test.startTest();
         System.enqueueJob(apc);
        Test.stopTest();
    }
    
}