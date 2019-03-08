public with sharing class NPSP_CommunityGroupController {

    @AuraEnabled(Cacheable=true)
    public static List<CLC_Community_Group__c> getAllGroups() {
        return [SELECT Id, Name, BillingStreet__c, BillingCity__c,
                BillingState__c, BillingPostalCode__c, Latitude__c, 
                Longitude__c 
                FROM CLC_Community_Group__c ORDER BY Name LIMIT 100];        
    }
    @AuraEnabled(Cacheable=true)
    public static List<CLC_Community_Group__c> searchGroups(String searchTerm) {
        // Return all bears when no search term
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getAllGroups();
        }
        // Prepare query paramters
        searchTerm = '%'+ searchTerm +'%';
        // Execute search query
        return [SELECT Id, Name, BillingStreet__c, BillingCity__c,
                BillingState__c, BillingPostalCode__c, Latitude__c, 
                Longitude__c
                FROM CLC_Community_Group__c 
                WHERE Name LIKE :searchTerm ORDER BY Name LIMIT 50];
    }    

    /*
    public static List<Account> getAllGroups() {
        return [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingCountry,
                Location__Latitude__s, Location__Longitude__s
            FROM Account WHERE Community_Group_Host__c = TRUE ORDER BY Name LIMIT 50];
    }
    
    @AuraEnabled(Cacheable=true)
    public static List<Account> searchGroups(String searchTerm) {
        // Return all bears when no search term
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getAllGroups();
        }
        // Prepare query paramters
        searchTerm = '%'+ searchTerm +'%';
        // Execute search query
        return [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingCountry,
                Location__Latitude__s, Location__Longitude__s
                FROM Account 
                WHERE Community_Group_Host__c = TRUE 
                AND Name LIKE :searchTerm ORDER BY Name LIMIT 50];
    }  
    **/  
}
