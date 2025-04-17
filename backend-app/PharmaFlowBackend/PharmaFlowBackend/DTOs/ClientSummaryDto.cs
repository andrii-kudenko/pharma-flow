namespace PharmaFlowBackend.DTOs;

public class ClientSummaryDto
{
    public Guid id { get; set; }
    public string name { get; set; } = "";
    public string company_name { get; set; } = "";
    public DateOnly? last_order_date { get; set; }
}