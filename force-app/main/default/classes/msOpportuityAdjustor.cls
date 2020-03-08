/**
 * Created by Matthias on 5/17/2018.
 */

public with sharing class msOpportuityAdjustor {

    public static void SetMinAmount(List<Opportunity> opp){

        for(Opportunity opps:opp){
            if(opps.Amount < 100){
                opps.Amount = 100;
        }

            update opp;
        }

        }
}