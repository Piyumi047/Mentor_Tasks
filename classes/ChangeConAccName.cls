public class ChangeConAccName {
    public static void updateAccName(List<Contact>oldList,List<Contact> cList,boolean IsInsert, boolean IsUpdate,boolean IsDelete){
      Set<String> accidset = new Set<String>();
      Set<String> oldAccidList = new Set<String>();
      List<Account> updateaccList = new List<Account>();
      List<Contact> conList = new List<Contact>();
      String conNames=''; 
      String oldAccName='';

      try{
         if(IsInsert || IsUpdate){
              for(contact c:cList){           
           	  	accidset.add(c.AccountId); 
              }
              
       //add all old acc name and id to map 
        Map<ID,Account> IdwithAccount=new Map<Id,Account>([Select id,Name from Account where id IN:accidset]);   
          
       //get list of all accounts
        //List<Account> existingAccounts=[Select id,Name from Account where id IN:accIdList]; 
             
        Account tempAcc = new Account();
        //check connected account has or not
                        
          for(contact c: cList){
              for(String aid:IdwithAccount.keyset()){           
                    if(c.AccountId==aid){
                        for(Contact c1:[Select LastName,Account.Name From Contact Where AccountId=: c.AccountId]){
                            if(conNames==null){
                              conNames=c1.LastName; 
                            }
                            conNames=conNames+' '+c1.LastName;                           
                        } 
                        oldAccName=IdwithAccount.get(aid).Name;
                        String accName=oldAccName.split(' ').get(0);
                        //String a1=accName.get(0);
                        tempAcc=IdwithAccount.get(aid);
                        tempAcc.Name=accName+' '+conNames;
                        //System.debug(a.Name);
                       
                        updateaccList.add(tempAcc);
                        //System.debug(a.Name);
                       
                   }
                }
              
          }
        
        
        }  
          
        if(IsDelete){
              for(contact c:oldList){           
           	  	accidset.add(c.AccountId); 
              }
              //get list of all accounts
              List<Account> existingAccounts=[Select id,Name from Account where id IN:accidset];
              for(contact c:oldList){           
           	  	
                  for(Account a:existingAccounts){
                      if(c.AccountId==a.Id){
                          String[] accName=a.Name.split(' ');
                          for(String i:accName){
                              if(i!=c.LastName){
                                 conNames=conNames+' '+i; 
                              }
                          }
                      }
                      a.Name=conNames;
                      updateaccList.add(a);
                  } 
              }
              
          }
 
        //System.debug('abcd'+existingAccounts);
                    
      }catch(Exception e){
            System.debug(e.getLineNumber());
      }
          
       if(updateaccList.size()>0){
           upsert updateaccList;
           //upsert conList;
       }     
     }
      
    }