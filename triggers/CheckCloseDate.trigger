trigger CheckCloseDate on Opportunity (before insert,before Update,after insert, after Update) {
    oppClosedate oppobj=new oppClosedate();
    oppclass cOpp=new oppclass();
    
    //check close date
    if(Trigger.isbefore && (Trigger.isInsert || Trigger.isUpdate)) 
    {
      oppClosedate.checkOppClosedate(Trigger.new); 
      //createContact.createmethod(trigger.new);    
    }
    
    //check opportunity list items
    if(Trigger.isafter && Trigger.isUpdate) 
    {       
      checkoppListItems.checkOpportunityList(Trigger.oldMap,Trigger.new);           
    }
    
    //check opportunity contact roles
    if(Trigger.isafter) 
    {   
        if(Trigger.isInsert || Trigger.isUpdate){
            oppConclass.createOpp(Trigger.new);
        }              
    }

}
