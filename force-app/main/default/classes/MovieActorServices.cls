global without sharing class MovieActorServices {
    
    public static void updateActorNumberOfMovies(List<MovieActor__c> moviesActors, Map<Id,MovieActor__c> oldMap, String context){
        Set<Id> actorsIds = new Set<Id>();
        List<Actor__c> actorsToUpdate = new List<Actor__c>();
        Map<Id,List<MovieActor__c>> mappedActors = new Map<Id,List<MovieActor__c>>();

        //get actors ids
        for(MovieActor__c mc : moviesActors){
            if(context == 'after insert' || context == 'after update' && mc.Actor__c != oldMap.get(mc.Id).Actor__c){
                actorsIds.add(mc.Actor__c);
            }
        }
        
        if(!actorsIds.isEmpty()){
            for(MovieActor__c mc : [SELECT id ,Actor__c FROM MovieActor__c WHERE Actor__c in :actorsIds]){
                if(!mappedActors.containsKey(mc.Actor__c)){
                    mappedActors.put(mc.Actor__c,new List<MovieActor__c>{mc});
                }else{
                    mappedActors.get(mc.Actor__c).add(mc);
                }
            }
            for(Actor__c ac : [SELECT NumberOfmovies__c FROM Actor__c WHERE id in :actorsIds]){
                ac.NumberOfmovies__c = mappedActors.get(ac.Id).size();
                actorsToUpdate.add(ac);
            }
        }
        
        try{
            TriggerHandler.bypass('MovieActorTriggerHandler');
            update actorsToUpdate;
        }catch(DMLException ex){
            for(MovieActor__c mc : moviesActors){
                mc.adderror(ex.getDMLMessage(0));
            }
        }finally{
            TriggerHandler.clearBypass('MovieActorTriggerHandler');
        }
    }
    
}
