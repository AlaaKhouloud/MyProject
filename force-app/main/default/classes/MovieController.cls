public with sharing class MovieController {

    @AuraEnabled
    public static List<Movie__c> getMovieList(String searchKey) {
        searchKey = '%'+searchKey+'%';
        return [
            SELECT Id, Name__c, Category__c,Description__c,ReleaseDate__c,Image__c
            FROM Movie__c
            WHERE Name__c LIKE :searchKey
            WITH SECURITY_ENFORCED
            LIMIT 10
        ];
    }
}
