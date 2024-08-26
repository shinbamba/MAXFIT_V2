@isTest
public class LocationTriggerHandlerTest {
    
    @isTest
    static void addLocation(){
		Test.startTest();
        
        Location__c loc = new Location__c (
        	Name = 'Honsha', 
            Street__c = 'Akebonocho, 2', 
            City__c = 'Akishima', 
            Postal_Code__c = '190012' , 
            State__c = '東京都',
            Country__c = 'Japan', 
            Verified__c = false
        );
        Test.setMock(HttpCalloutMock.class, new MockCallout());
        insert loc;
        Test.stopTest();
        // Assert.areEqual(true)
    }
}