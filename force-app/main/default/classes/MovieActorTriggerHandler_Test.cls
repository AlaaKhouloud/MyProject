@isTest
public class MovieActorTriggerHandler_Test {

    @isTest
    public static void updateActorNumberOfMovies_Test(){
        List<Movie__c> movies = (List<Movie__c> ) TestDataFactory.createSObjectList('Movie__c',40);
        List<Actor__c> actors = (List<Actor__c> ) TestDataFactory.createSObjectList('Actor__c',10);
        List<MovieActor__c> acts = new List<MovieActor__c>();
        for(Movie__c movie : movies){
            MovieActor__c a = new MovieActor__c(Actor__c = actors[0].Id, Movie__c = movie.Id);
            acts.add(a);
        }
        Test.startTest();
            insert acts;

            acts = [SELECT id ,Actor__c FROM MovieActor__c];
            for(integer i=0;i<10;i++){
                acts[i].Actor__c = actors[i].Id;
            }
            update acts;
		Test.stopTest();
            
        List<Actor__c> actorsResult = [SELECT id , NumberOfmovies__c FROM Actor__c];
		System.assertEquals(actorsResult[1].NumberOfmovies__c,1);
    }
}