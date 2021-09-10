global class MyBatchClass implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, IsReleased__c FROM Movie__c WHERE ReleaseDate__c <= TODAY AND IsReleased__c = false';
        return Database.getQueryLocator(query);
    }
     
    global void execute(Database.BatchableContext BC, List<Movie__c> movies) {
        
        // process each batch of records default size is 200
        for(Movie__c m : movies) {        
           m.IsReleased__c = true;
        }
        try {
            update movies;
         
        } catch(Exception e) {
            System.debug(e);
        }
         
    }   
     
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
      
}