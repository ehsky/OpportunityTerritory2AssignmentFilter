/* Test class for OppTerrAssignDefaultLogicFilter class provided by Salesforce platform
 * This test class does not have any system.asserts as the territory assignment rules are not triggered
 * when done through Apex.
 */
@isTest
private class OppTerrAssignDefaultLogicFilterTest {
    @isTest
    private static void testActiveModel() {
        // This method is just for code coverage. You can't activate a territory model from code.
        OppTerrAssignDefaultLogicFilter filter = new OppTerrAssignDefaultLogicFilter();
        Id modelId = filter.ActiveModelId;
    }

    @isTest
    private static void testOppTerritory() {
        Territory2 terr = new Territory2();
        Territory2 terr2 = new Territory2();
        OppTerrAssignDefaultLogicFilter filter = new OppTerrAssignDefaultLogicFilter();

        System.runAs(new User(Id = UserInfo.getUserId())) {
            Territory2Model tm = new Territory2Model(
                Name = 'test',
                DeveloperName = 'test'
            );
            insert tm;

            filter.ActiveModelId = tm.Id; //set the active model Id since it can't be queried

            Territory2Type tt = [SELECT Id FROM Territory2Type LIMIT 1];

            terr = new Territory2(
                Name = 'Test Territory',
                DeveloperName = 'TestTerritory',
                Territory2ModelId = tm.Id,
                Territory2TypeId = tt.Id
            );
            insert terr;

            terr2 = new Territory2(
                Name = 'Test Territory2',
                DeveloperName = 'TestTerritory2',
                Territory2ModelId = tm.Id,
                Territory2TypeId = tt.Id
            );
            insert terr2;
        }

        Account a = (Account) TestFactory.createSObject(new Account(), true);

        ObjectTerritory2Association ota = new ObjectTerritory2Association(
            AssociationCause = 'Territory2Manual',
            ObjectId = a.Id,
            Territory2Id = terr.Id
        );
        insert ota;

        Opportunity opp = (Opportunity) TestFactory.createSObject(
            new Opportunity(AccountId = a.Id),
            true
        );

        Map<Id, Id> resultMap = filter.getOpportunityTerritory2Assignments(
            new List<Id>{ opp.Id }
        );

        System.assertEquals(terr.Id, resultMap.get(opp.Id));

        ObjectTerritory2Association ota2 = new ObjectTerritory2Association(
            AssociationCause = 'Territory2Manual',
            ObjectId = a.Id,
            Territory2Id = terr2.Id
        );
        insert ota2;

        resultMap = filter.getOpportunityTerritory2Assignments(
            new List<Id>{ opp.Id }
        );

        System.assertEquals(
            null,
            resultMap.get(opp.Id),
            'No territory should be assigned as 2 have the same priority'
        );
    }
}
