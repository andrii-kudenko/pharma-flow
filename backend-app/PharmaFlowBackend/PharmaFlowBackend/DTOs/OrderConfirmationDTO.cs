namespace PharmaFlowBackend.DTOs;

public class OrderConfirmationDTO
{
    public Guid id { get; set; }
    public string order_number { get; set; }
    public int total_items { get; set; }
    public DateTime created_at { get; set; }
}