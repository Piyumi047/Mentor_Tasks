public class oppclass {
   public static String createOpp(List<Opportunity> opsNewlist,Map<ID,Opportunity>oldMap){ 
       List<OpportunityContactRole> conrole=new List<OpportunityContactRole>();
        try{
            for(Opportunity op:opsNewlist){ 
               List<Contact> con=[Select Id from Contact where AccountId=:op.AccountId];
                for(Contact c:con){
                    OpportunityContactRole newOpCon=new OpportunityContactRole();
                    newOpCon.OpportunityId=op.Id;
                    newOpCon.ContactId=c.Id;
                    conrole.add(newOpCon);
                }                            
            }	
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
       
       //check the list empty or not
        if(conrole.size()>0){
            upsert conrole;
        }
        return('');
    }
    
   
}