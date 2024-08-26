public class LocationTriggerHandler {
    @future(callout=true)
    public static void verifyAddress( String recordId) {
        Location__c location = [Select Id,Name, Street__c, City__c, Postal_Code__c, State__c,Country__c, Verified__c From Location__c where id=: recordId];
        String baseURL = 'http://api.weatherapi.com/v1/current.json?';
        baseURL += 'key=2114d82c3166471697404730240708'
            + '&q='+ EncodingUtil.urlEncode(location.City__c, 'UTF-8')
            + '&api=no';
        HttpRequest httpReq = new HttpRequest();
        httpReq.setMethod('GET');
        httpReq.setEndpoint(baseURL);
        httpReq.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HttpResponse httpRes = new HttpResponse();
		httpRes = http.send(httpReq);
        
        try{
            httpRes = http.send(httpReq);
            System.debug('ResponseBody: ' + httpRes.getBody());
            if (httpRes.getStatusCode() == 200 && httpRes.getStatus() == 'OK'){
                    location.Verified__c = true;
                    update location;
                }
            else if (httpRes.getStatusCode() == 400){
                    location.Verified__c = false;
                    update location;
                }
            else {
                TransactionLogHandler.doHandleExceptionwithError( httpRes.getBody(), 'LocationTriggerHandler');
            }
        }catch(System.CalloutException ex){
            System.debug('Exception Executed' + ex.getStackTraceString());
            TransactionLogHandler.doHandleException(ex, 'LocationTriggerHandler');
        }
    }
}