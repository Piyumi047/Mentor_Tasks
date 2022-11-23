global class scheduleb1 implements Schedulable {
   global void execute(SchedulableContext sc){
      b1  AccDel= new b1();
      database.executeBatch(AccDel, 10);
   }
}