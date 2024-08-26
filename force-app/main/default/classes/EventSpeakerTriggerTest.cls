@isTest
public class EventSpeakerTriggerTest {
    
    @isTest
    public static void setupData(){
        //Create Test Data
        Event_Organizer__c  org = new Event_Organizer__c (
            Name = 'Shin Bamba',
            Phone__c = '08057668797',
            Email__c = 'shin_bamba@adoc.co.jp',
            Alternative_Phone__c  = '2126795231',
            Alternative_Email__c ='bambashin@gmail.com'
        );
        insert org;
        
        Event__c event1 = new Event__c (
       		Name__c = 'test_event_1',
            Event_Organizer__c  = org.Id,
            Event_Type__c = 'Virtual',
            Frequency__c  = 'Weekly',
            Max_Seats__c  = 199,
            Recurring__c = true,
            Live__c = true,
            Start_DateTime__c = System.now(),
            End_Date_Time__c  = System.now().addDays(3)
        );
        
        Event__c event2 = new Event__c (
        	Name__c = 'test_event_2',
            Event_Organizer__c  = org.Id,
            Event_Type__c = 'Virtual',
            Max_Seats__c  = 50,
            Recurring__c = false,
            Live__c = true,
            Start_DateTime__c = System.now(),
            End_Date_Time__c  = System.now().addDays(2)
        );
        
        Event__c event3 = new Event__c (
        	Name__c = 'test_event_3',
            Event_Organizer__c  = org.Id,
            Event_Type__c = 'Virtual',
            Max_Seats__c  = 500,
            Recurring__c = false,
            Live__c = true,
            Start_DateTime__c = System.now().addDays(5),
            End_Date_Time__c  = System.now().addDays(7)
        );
        
        insert event1;
        insert event2;
        insert event3;
        
 		Speaker__c	test_speaker = new Speaker__c(
       		Name = 'Youhei Yasu',
            Email__c = 'youhei_yasu@adoc.co.jp',
            Phone__c = '08057634655'
        ); 
        insert test_speaker;
        
        EventSpeakers__c event1_speaker = new EventSpeakers__c (
			Speaker__c = test_speaker.id,
            Event__c = event1.id
        );
        insert event1_speaker;
        EventSpeakers__c event2_speaker = new EventSpeakers__c (
			Speaker__c = test_speaker.id,
            Event__c = event2.id
        );
        
   		Test.startTest();
        
        Database.SaveResult result =  Database.Insert(event2_speaker, false);
        Test.stopTest();
        // Verify Error is reported
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The speaker is already booked at that time',
                             result.getErrors()[0].getMessage());
    }
    
}