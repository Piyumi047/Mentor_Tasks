public class oppClosedate{
    
    public static Void checkOppClosedate(List<Opportunity> opslist){       
        try{
            for(Opportunity op:opslist){ 
                //check the date
               if(op.CloseDate<Date.today()){
                   op.CloseDate.addError('please enter future close date');                                                    
               }
            }	
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }         
        
    }
   
}