trigger MovieActorTrigger on MovieActor__c (
    after insert,
    before insert,
    after update,
    before update,
    after delete,
    before delete,
    after undelete) {
        new MovieActorTriggerHandler().run();
}