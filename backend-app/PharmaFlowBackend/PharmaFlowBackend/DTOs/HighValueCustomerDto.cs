namespace PharmaFlowBackend.DTOs
{
    public class HighValueCustomerDto
    {
        public Guid ClientId { get; set; }
        public string? CompanyName { get; set; }
        public int OrdersCount { get; set; }
        public decimal TotalSpent { get; set; }
        public decimal AverageOrderValue { get; set; }
        public DateTime? LastOrderDate { get; set; }
    }
}
