public class checkoppListItems {
	//check opportunity list items
    public static String checkOpportunityList(Map<Id,Opportunity>oldMap,List<Opportunity>opsnewlist){
        Map<Id,Opportunity> allOpportunity = new Map<Id,Opportunity>();
        Set<String> listItemIds = new Set<String>();
        try{
            for(Opportunity opps:opsnewlist){ 
                //check is it CLosedwon or Closed lost or not previous
                if((oldMap.get(opps.Id).StageName != 'Closed Won' || oldMap.get(opps.Id).StageName != 'Closed Lost')){
                   // check stage name 
                    if((opps.StageName == 'Closed Won' || opps.StageName == 'Closed Lost')){
                        allOpportunity.put(opps.Id,opps);                      
                    }
                }               
            }
            
            // check allopportunity is empty or not 
            if(allOpportunity.size()>0){
                
                // get all opportunity list items for a opportunity id  one by one 
                for(List<OpportunityLineItem> oppItemList: [Select Id,OpportunityId,Product2Id,ProductCode,Name from OpportunityLineItem where OpportunityId !='' AND OpportunityId In :allopportunity.keySet()]){
                    //check that opportunity id has list item or not 
                    if(oppItemList.size()<1){
                        
                        opsnewlist[0].addError('opportunity cannot be closed');
                    }
                }
             }         
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }         
        return('');
    }
}