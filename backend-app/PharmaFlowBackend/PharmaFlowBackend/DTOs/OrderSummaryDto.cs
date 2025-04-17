namespace PharmaFlowBackend.DTOs;

public class OrderSummaryDto
{
    public Guid id { get; set; }
    public string order_number { get; set; } = "";
    public string status { get; set; } = "";
    public string client_name { get; set; } = "";
    public string company_name { get; set; } = "";
}