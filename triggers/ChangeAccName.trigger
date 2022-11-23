trigger ChangeAccName on Contact (after insert,after update, after delete){   
    ChangeConAccName.updateAccName(Trigger.old,Trigger.new,Trigger.isInsert,Trigger.isUpdate,Trigger.isDelete);
 }