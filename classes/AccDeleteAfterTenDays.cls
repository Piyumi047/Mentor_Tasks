public class AccDeleteAfterTenDays implements Database.Batchable<sObject>{

   public Database.QueryLocator start(Database.BatchableContext BC){
      //set the date
      Date s = system.today()-10;
       
      //get all account related to Date 
      string query = 'select id  from Account where createDdate <:s';
      return Database.getQueryLocator(query);
   }

   public void execute(Database.BatchableContext BC, List<sObject> scope){
     //check scope empty or not 
     if(scope.size()>0)
        delete scope;
    }

   public void finish(Database.BatchableContext BC){
       system.debug('Execute the AccDeleteAfterTenDays batchapex');
   }
}