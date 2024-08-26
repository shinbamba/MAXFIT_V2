public class TransactionLogHandler {

    public static void doHandleException(System.Exception ex, String processName){
        
        Error_Log__c transactionLog = new Error_Log__c (
            Log_Details__c = ex.getStackTraceString() +  '<br> <strong> Message is </strong>	' + ex.getMessage() 
                + '<br>' + ex.getCause() + '<br/>' + ex.getTypeName() + '<br>' + ex.getLineNumber(),
                Lod_DateTime__c = System.Now(),
                Process_Name__c = processName
        );
          insert transactionLog;
    }
    
    public static void doHandleExceptionwithError(String errors, String processName){
        
        Error_Log__c transactionLog = new Error_Log__c (
            Log_Details__c = errors,
                Lod_DateTime__c = System.Now(),
                Process_Name__c = processName
        );
          insert transactionLog;
    }
}