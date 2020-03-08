/**
 * Created by Matthias on 5/17/2018.
 */

@isTest
public with sharing class TestDataFactory {

    public static List<Opportunity> createTestOpps(Integer OppNumber){
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i = 0; i < OppNumber; i++){
            Opportunity opp = new Opportunity(Name='Opp'+i, StageName ='Prospecting', CloseDate = Date.today(),Amount=0);
            opps.add(opp);
        }
        insert opps;
        return opps;
    }
}