import ballerina/http;

service /salesservice on new http:Listener(8090) {

    resource function post sales(http:Caller caller, http:Request request) returns error? {
        
        // Parse the incoming JSON request
        json requestPayload = check request.getJsonPayload();
        SalesRequest salesRequest = check requestPayload.cloneWithType(SalesRequest);
        
        // Extract items array for inventory service call
        ItemDetail[] items = salesRequest.items;
        
        // First call to inventory service
        http:Response inventoryResponse = check inventoryClient->post(path = "/inventory", message = items);
        json inventoryPayload = check inventoryResponse.getJsonPayload();
        InventoryResponse inventoryResult = check inventoryPayload.cloneWithType(InventoryResponse);
        
        // Prepare request for invoice service
        InvoiceRequest invoiceRequest = {
            totalAmount: inventoryResult.totalAmount,
            countryCode: salesRequest.countryCode
        };
        
        // Second call to invoice service
        http:Response invoiceResponse = check invoiceClient->post(path = "/invoice", message = invoiceRequest);
        json invoicePayload = check invoiceResponse.getJsonPayload();
        InvoiceResponse invoiceResult = check invoicePayload.cloneWithType(InvoiceResponse);
        
        // Prepare and send response
        SalesResponse salesResponse = {
            finalAmount: invoiceResult.finalAmount
        };
        
        check caller->respond(salesResponse);
    }
}