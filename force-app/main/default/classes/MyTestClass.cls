/**
 * Created by Matthias on 5/17/2018.
 */

@IsTest
public with sharing class MyTestClass {

    @TestSetup
    static void setup(){
        List<Opportunity> opps = TestDataFactory.createTestOpps(20);
        Integer count = 0;
        for(Opportunity o:opps){
            o.Amount += count*10;
            count++;
        }
        update opps;
    }

    @IsTest
    static void SetMinAmountTest(){
        List<Opportunity> oppList = [SELECT Id, Amount FROM Opportunity];


        Test.startTest();
        msOpportunityAdjustor.SetMinAmount(oppList);
        Test.stopTest();

        System.assertEquals(True,[SELECT Id FROM Opportunity WHERE Amount<100].isEmpty());

    }
}

//Name, StageName, CloseDate