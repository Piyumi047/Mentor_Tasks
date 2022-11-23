public class createContact {
	list<Contact> con = new list<Contact>();
    public void createmethod(List<Account> accList){
     try{
           for(account acc:accList){
                //create the contact instanse
                contact c1=new contact();
                c1.LastName=acc.Name;
                c1.AccountId=acc.Id;
                con.add(c1);
            }
  
      }catch(Exception e){
            System.debug(e.getLineNumber()+ 'Contact not created');
      }
        
        //check the list empty or not
        if(con.size()>0){
            insert con;
        }
    }
}