global class CreateOppBatch implements Database.Batchable<sObject>{

	global Database.QueryLocator start(Database.BatchableContext BC){
		String query = 'SELECT Id,Name FROM Opportunity LIMIT 1';
		return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Opportunity> scope){
		List <opportunity> oppnew = new List<opportunity>(); 
		for(integer i=1;i<6;i++){
			Opportunity opp = new Opportunity();
			opp.name = 'Test' + i;
			opp.StageName = 'Prospecting';
			opp.CloseDate = Date.Today();
			oppnew.add(opp);
	    }
        insert oppnew;

    } 


	global void finish(Database.BatchableContext BC){
        system.debug('**** Finish');
	}

}