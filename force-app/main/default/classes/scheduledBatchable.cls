global class scheduledBatchable implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        MyBatchClass b = new MyBatchClass(); 
        Database.executeBatch(b);
    }

 }
 