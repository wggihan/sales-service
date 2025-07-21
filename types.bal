// Request and response types for the sales service

public type SalesRequest record {
    string countryCode;
    ItemDetail[] items;
};

public type ItemDetail record {
    string name;
    decimal price;
    int quantity;
};

public type InventoryResponse record {
    decimal totalAmount;
};

public type InvoiceRequest record {
    decimal totalAmount;
    string countryCode;
};

public type InvoiceResponse record {
    decimal finalAmount;
};

public type SalesResponse record {
    decimal finalAmount;
};