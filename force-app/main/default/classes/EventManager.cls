@RestResource(urlMapping='/v1/futureEvent')
global class EventManager {
	//https://back-to-basic-dev-ed.my.salesforce.com/services/apexrest/v1/futureEvent
	
    @httpGET
    global static List<Event__c> upcomingEvents(){
        List<Event__c> eventList = [SELECT Id, IsDeleted, Name, CreatedDate, End_Date_Time__c, Event_Type__c, Location__c,  Event_Detail__c,
                                    Max_Seats__c, Name__c, Recurring__c, Start_DateTime__c, Status__c, PeopleAttending__c, Location_Verified__c, Remaining_Seats__c,
                                    Location__r.Name, Location__r.Street__c, Location__r.City__c, Location__r.Postal_Code__c, Location__r.Country__c, Location__r.State__c,
                                    Event_Organizer__c, Event_Organizer__r.Name, Event_Organizer__r.Email__c  
                                    FROM Event__c 
                                    WHERE Start_DateTime__c >= TODAY AND Live__c = true
                                    WITH SECURITY_ENFORCED
                                   ];
        return eventList;
    }
    
   
    /*
    @httpPOST
    global static String postEvents(){
        return 'Hello POST';
    }
	*/
}