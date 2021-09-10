@isTest
public class BatchApexTest {
    
    @isTest
    public static void testBatch() {
        // Create test accounts to be updated by batch
        List<Movie__c> movieList = new List<Movie__c>();

        for (Integer i=0;i<50;i++) {
            Movie__c m = new Movie__c(Name__c = 'Movie ' + i, ReleaseDate__c = Date.newInstance(2016, 12, 9));
            movieList.add(m);
        }

        insert movieList;
    
            Test.startTest();
                MyBatchClass b = new MyBatchClass();
                Database.executeBatch(b);
            Test.stopTest();

            // Verify accounts updated
            Movie__c[] updatedList = [SELECT IsReleased__c FROM Movie__c];

        System.assertEquals(updatedList[0].IsReleased__c,true);
    }

}
