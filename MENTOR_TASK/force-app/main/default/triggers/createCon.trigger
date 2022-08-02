trigger createCon on Account (after insert,after update) {
    Set<String> accidList = new Set<String>();
    List<Account> updateaccList = new List<Account>();
    createContact obj=new createContact();
    String conNames=''; 
    String oldAccName='';

    
    if(trigger.isafter && trigger.isinsert) 
    {
     obj.createmethod(trigger.new); 
     //createContact.createmethod(trigger.new); 
    }
      
}
