@isTest
private class NPSP_CommunityGroupControllerTest {

    @isTest 
    static void getAllGroups() {
        Account act = new Account();
        act.Name = 'Test' ;
        act.BillingStreet = '1298 34st N' ;
        act.BillingCity = 'St Petrsburg';
        act.BillingState = 'FL';
        act.BillingPostalCode = '33709';
        insert act;

        List<CLC_Community_Group__c> lst = NPSP_CommunityGroupController.getAllGroups();

    }

    @isTest
    static void searchGroups(){
    Account act = new Account();
        act.Name = 'Test' ;
        act.BillingStreet = '1298 34st N' ;
        act.BillingCity = 'St Petrsburg';
        act.BillingState = 'FL';
        act.BillingPostalCode = '33709';
        insert act;

        List<CLC_Community_Group__c> lst = NPSP_CommunityGroupController.searchGroups('Test');
        lst = NPSP_CommunityGroupController.searchGroups('');
            
    }
}
