@isTest
public class DeleteEventBatchTest {
    @testSetup
    public static void testSetUpData(){
       //Create Test Data
        Event_Organizer__c  org = new Event_Organizer__c (
            Name = 'Shin Bamba',
            Phone__c = '08057668797',
            Email__c = 'shin_bamba@adoc.co.jp',
            Alternative_Phone__c  = '2126795231',
            Alternative_Email__c ='bambashin@gmail.com'
        );
        insert org;
        
        List<Event__c> eventList = new List<Event__c>();
        for (integer i=0; i<=200; i++) {
            Event__c event = new Event__c (
                Name__c = 'test_event_1',
                Event_Organizer__c  = org.Id,
                Event_Type__c = 'Virtual',
                Max_Seats__c  = 199,
                Recurring__c = false,
                Live__c = true,
                Start_DateTime__c = System.now().addMonths(-4),
                End_Date_Time__c  = System.now().addDays(3).addMonths(-4)
       		);
            eventList.add(event);
        }
        
        
        insert eventList;
    }
    
    @istest
    static void sendDeleteEvent(){
        Test.startTest();
        String jobId = Database.executeBatch(new DeleteEventBatch(), 250);
        Test.stopTest();
    }
}