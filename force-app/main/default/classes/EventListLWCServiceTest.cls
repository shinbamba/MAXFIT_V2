@isTest
public class EventListLWCServiceTest {
    
    @isTest
    static void CreateEventList(){
        Test.startTest();
		EventListLWCService.fetchUpComingEvents();
        
        EventListLWCService.fetchPastEvents();
        Test.stopTest();
    }
    
    @isTest
    static void CreateAttendeeList(){
        Attendee__c att = new Attendee__c(
            Name = 'Akash Jain',
            Email__c = 'akash.jain@gmail.com',
            Phone__c = '9807654321'
        );
        insert att;
        
        Test.startTest();
        AttendeeEventsService.upcomingEvets(att.id);
        AttendeeEventsService.pastEvents(att.Id);
        Test.stopTest();
    }
    
    @isTest
    static void CreateEventDetailsList(){
        Event_Organizer__c  org = new Event_Organizer__c (
            Name = 'Shin Bamba',
            Phone__c = '08057668797',
            Email__c = 'shin_bamba@adoc.co.jp',
            Alternative_Phone__c  = '2126795231',
            Alternative_Email__c ='bambashin@gmail.com'
        );
        insert org;
        
        Event__c event = new Event__c (
       		Name__c = 'test_event_1',
            Event_Organizer__c  = org.id,
            Event_Type__c = 'Virtual',
            Frequency__c  = 'Weekly',
            Max_Seats__c  = 199,
            Recurring__c = true,
            Live__c = true,
            Start_DateTime__c = System.now(),
            End_Date_Time__c  = System.now().addDays(3)
        );
        insert event;
        
        Test.startTest();
        EventDetailsController.getSpeakers(event.id);
        EventDetailsController.getLocationDetails(event.id);
        EventDetailsController.getAttendees(event.id);
        Test.stopTest();
    }
}