trigger oppLI on OpportunityLineItem (after insert) {
    if(trigger.isafter && trigger.isinsert) 
      {
         opportunityLI.createoppLI(trigger.new); 
          //createContact.updatemethod(trigger.new);    
      }
  }