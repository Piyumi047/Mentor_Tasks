global class scheduleAccDeleteAfterTenDays implements Schedulable {
   global void execute(SchedulableContext sc){
      AccDeleteAfterTenDays  AccDel= new AccDeleteAfterTenDays();
      database.executeBatch(AccDel, 10);
   }
}