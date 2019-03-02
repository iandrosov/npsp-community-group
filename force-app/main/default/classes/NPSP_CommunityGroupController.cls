public with sharing class NPSP_CommunityGroupController {
    public NPSP_CommunityGroupController() {

    }

    @AuraEnabled(Cacheable=true)
    public static Account[] getAllGroups() {
        return [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingCountry
            FROM Account WHERE Community_Group_Host__c = TRUE ORDER BY Name LIMIT 50];
    }

    @AuraEnabled(Cacheable=true)
    public static Account[] searchGroups(String searchTerm) {
        // Return all bears when no search term
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getAllGroups();
        }
        // Prepare query paramters
        searchTerm = '%'+ searchTerm +'%';
        // Execute search query
        return [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingCountry
            FROM Account WHERE Community_Group_Host__c = TRUE AND Name LIKE :searchTerm ORDER BY Name LIMIT 50];
    }    
}
