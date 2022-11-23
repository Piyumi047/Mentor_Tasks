public class opportunityLI {
 public static void createoppLI(List<OpportunityLineItem> itemlist){
       Set<Id> oppIds = new Set<Id>();
       Map<Id,Integer> lineItemcount=new Map<Id,Integer>();
        try{
            //get all items related  opportunity ids
            for(OpportunityLineItem item:itemlist) {
                oppIds.add(item.OpportunityId);
            }
            
            //get all the opportunity id's which opportunity list item grater than 2
            Set<Id> extras = new Map<Id, AggregateResult>([
                SELECT OpportunityId Id
                FROM OpportunityLineItem
                WHERE OpportunityId IN :oppIds
                GROUP BY OpportunityId
                HAVING COUNT(Id) > 2
            ]).keySet();
            
            //check new inseted items realted  oppportunituy id is in the set or not
            for(OpportunityLineItem record:itemlist) {
                if(extras.contains(record.OpportunityId)) {
                    record.addError('You cannot have more than two lines on an opportunity.');
                }
            }
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
  }
}