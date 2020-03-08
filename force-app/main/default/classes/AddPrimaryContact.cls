public class AddPrimaryContact implements Queueable{
    private Contact myContact;
    private String stateAbbr;
    
    public AddPrimaryContact(Contact myContact, String stateAbbr){
        this.myContact=myContact;
        this.stateAbbr=stateAbbr;
    }
    public void execute(QueueableContext context){
        List<Account> accLst = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE BillingState = :stateAbbr LIMIT 200]; 
    	List<Contact> contactLst = new List<Contact>();
        
        for(Account acc:accLst){
            Contact cont = myContact.clone(false,false,false,false);
            cont.AccountID = acc.Id;
            contactLst.add(cont);
        }
        if(contactLst.size()>0){
            insert contactLst;
        }
        
    }

}