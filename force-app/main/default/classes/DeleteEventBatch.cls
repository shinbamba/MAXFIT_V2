public class DeleteEventBatch implements Database.Batchable<sObject> {
	
    public Database.QueryLocator start(Database.BatchableContext batchContext) {
        // Query to locate related data
        String Query = 'Select Id, Name From Event__c Where Live__c = true AND End_Date_Time__c < LAST_N_MONTHS:2';
        return Database.getQueryLocator(Query);
    }
    
    public void execute(Database.BatchableContext batchContext, List<Event__c> eventlist) {
        if(!eventList.isEmpty()){
            List<Database.DeleteResult> deleteResult = Database.delete(eventlist);
            for (Database.DeleteResult dr : deleteResult){
                if (!dr.isSuccess()){
                    List<Database.Error> errors = dr.getErrors();
                    String stringError = String.join(errors, ',');
                    TransactionLogHandler.doHandleExceptionwithError(stringError, 'DeleteEventBatch');
                }
            }
        }
    }
    
    public void finish(Database.BatchableContext batchContext) {
        /*
        //Send email to administrator
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('Batch Deletion Completed');
        List<string> toAddress =  new List<String>();
        toAddress.add('shin_bamba@adoc.co.jp');
        mail.setToAddresses( toAddress );
        mail.setSenderDisplayName('Bamba Shin');
        
        mail.setHtmlBody('The DeleteEventBatch Batch Prcoessing has been completed');
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage> {mail};
        Messaging.sendEmail(emails);
		*/
    }
}