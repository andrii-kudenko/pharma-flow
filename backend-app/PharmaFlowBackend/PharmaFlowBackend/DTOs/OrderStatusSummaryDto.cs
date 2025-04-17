namespace PharmaFlowBackend.DTOs;

public class OrderStatusSummaryDto
{
    public int Pending { get; set; }
    public int Confirmed { get; set; }
    public int Shipped { get; set; }
    public int Completed { get; set; }
}