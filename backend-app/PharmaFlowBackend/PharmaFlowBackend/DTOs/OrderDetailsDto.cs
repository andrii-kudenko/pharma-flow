namespace PharmaFlowBackend.DTOs;

public class OrderDetailsDto
{
    public Guid id { get; set; }
    public string order_number { get; set; } = "";
    public string status { get; set; } = "";
    public string client_name { get; set; } = "";
    public string company_name { get; set; } = "";
    public string delivery_address { get; set; } = "";
    public string? note { get; set; }
    public int total_items { get; set; }
    public decimal total_price { get; set; }
    public List<ProductInfo> products { get; set; } = new();
}

public class ProductInfo
{
    public string code_name { get; set; } = "";
    public string description { get; set; } = "";
    public int quantity { get; set; }
    public decimal price_per_unit { get; set; }
}