global class CountAccConBatch implements Database.Batchable<sObject>{
	global Database.QueryLocator start(Database.BatchableContext BC){
		String query = 'SELECT Id,Name,(SELECT Id FROM Contacts) FROM Account';
		return Database.getQueryLocator(query);
	}

 	global void execute(Database.BatchableContext BC, List<Account> allAcc){
		list<Account> accList = new list<Account>();
			for(Account acc: allAcc){
				acc.count__c = acc.Contacts.size();
				accList.add(acc);
			}
		update accList;
   }
   
    global void finish(Database.BatchableContext BC){
        system.debug('*******finish**********');
		AsyncApexJob a = [Select Id, Status,ExtendedStatus,NumberOfErrors,     JobItemsProcessed,
        TotalJobItems, CreatedBy.Email
        from AsyncApexJob where Id =:BC.getJobId()];
          
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Accounts Count Field update ' + a.Status);
        mail.setPlainTextBody('records processed ' + a.TotalJobItems +
       'with '+ a.NumberOfErrors + 'failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}