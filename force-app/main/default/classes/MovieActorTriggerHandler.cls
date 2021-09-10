public class MovieActorTriggerHandler extends TriggerHandler{
    
    private Map<Id,MovieActor__c> newMAC;
    private Map<Id,MovieActor__c> oldMAC;
    
    public MovieActorTriggerHandler(){
        this.newMAC = (Map<Id,MovieActor__c>) Trigger.newMap;
        this.oldMAC = (Map<Id,MovieActor__c>) Trigger.oldMap;
    }

    public override void afterUpdate(){
        MovieActorServices.updateActorNumberOfMovies(Trigger.new, this.oldMAC, 'after update');
    }

    public override void afterInsert(){
        MovieActorServices.updateActorNumberOfMovies(Trigger.new, null, 'after insert');
    }

}
