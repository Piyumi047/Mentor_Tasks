@isTest
public class TestCountAccConBatch{
    
	@isTest
    public static void testUpdateAccount(){
        Account[] aList= new List<Account>();
        for(integer i=0; i<=5; i++){
           Account accnew = new Account();
           accnew.Name='Test'+i;
           aList.add(accnew);
        }
        Insert aList;
        
        Test.startTest();        
        CountAccConBatch b = new CountAccConBatch();
		database.executebatch(b);       
        Test.stopTest();
     }
      
}