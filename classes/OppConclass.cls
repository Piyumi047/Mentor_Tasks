public class OppConclass{
    
    //create and update contact roles
    public static void createOpp(List<Opportunity> opsNewlist){ 
        //for get the all accIds
        Set<String> accIds = new Set<String>();
        Set<Id> cnIds = new Set<Id>();
        
        //create opportunity contact role list
        List<OpportunityContactRole> oppConlist=new List<OpportunityContactRole>();
        
        try{
            //set the all account ids
            for(Opportunity op:opsNewlist){ 
                accIds.add(op.AccountId);               
            }
            
            //get all contact for thoes accounts
            List<Contact> allcon=new List<Contact>();
            allcon=[Select Id, AccountId from Contact where AccountId IN:accIds];
            
            //map the account and related contacts
            Map<Id,List<Contact>> AccMapCon= new Map<Id,List<Contact>>();
            for(Contact c:allcon){
                if(AccMapCon.get(c.AccountId)==null){
                    AccMapCon.put(c.AccountId,new List<Contact>());                   
                }
                AccMapCon.get(c.AccountId).add(c);
            }
            //System.debug(AccMapCon);
            
            //check the existing contact roles
            List<OpportunityContactRole> OCR=[Select Id,OpportunityId from OpportunityContactRole where OpportunityId In:opsNewlist];
            
            //get all  opportunity id related contacts(no diplicate ids)
            for(OpportunityContactRole ocrlist:OCR){
                if(!cnIds.contains(ocrlist.OpportunityId)){
                    cnIds.add(ocrlist.OpportunityId);
                    //System.debug('abcd cdbd'+cnIds);
                }
            }
            
                       
            for(Opportunity op1:opsNewlist){ 
                
                //check opp id is not in the existing id list and check opp has related new acc and contacts 
                if(!cnIds.contains(op1.Id) && AccMapCon.get(op1.AccountId)!=null){
                   Boolean firstContact = true;
                    for(Contact c1: AccMapCon.get(op1.AccountId)){
                        OpportunityContactRole nocr= new OpportunityContactRole(OpportunityId=op1.id,ContactId=c1.Id);
                        if(firstContact){
                            nocr.IsPrimary=True;
                            firstContact=false;
                        }
                        oppConlist.add(nocr);
                    }
                }
                
                //check opp id is in the existing id list and check opp has related new acc and contacts
                else if(cnIds.contains(op1.Id) && AccMapCon.get(op1.AccountId)!=null){
                    List<OpportunityContactRole> oldcon=[select Id from OpportunityContactRole where OpportunityId=:op1.Id];
                    delete oldcon;
                    Boolean firstContact = true;
                    for(Contact c1: AccMapCon.get(op1.AccountId)){
                        OpportunityContactRole nocr= new OpportunityContactRole(OpportunityId=op1.id,ContactId=c1.Id);
                        if(firstContact){
                            nocr.IsPrimary=True;
                            firstContact=false;
                        }
                        oppConlist.add(nocr);
                    }
                }                    
            }           
            //insert oppConlist;      
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
       
        //check the list empty or not
        if(oppConlist.size()>0){
            insert oppConlist;
        }        
    }
}