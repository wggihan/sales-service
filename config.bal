import ballerina/http;

// Configurable URLs for external services
configurable string inventoryServiceUrl = "http://localhost:8081/inventoryservice";
configurable string invoiceServiceUrl = "http://localhost:8090/invoiceservice";

// HTTP clients for external services
final http:Client inventoryClient = check new (inventoryServiceUrl);
final http:Client invoiceClient = check new (invoiceServiceUrl);