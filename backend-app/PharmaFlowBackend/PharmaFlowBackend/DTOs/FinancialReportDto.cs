namespace PharmaFlowBackend.DTOs
{
    public class FinancialReportDto
    {
        public decimal TotalRevenue { get; set; }
        public int TotalOrders { get; set; }
        public decimal AverageOrderValue { get; set; }
        public int ItemsSold { get; set; }
        public TopCustomerDto? TopCustomer { get; set; }
        public IEnumerable<MonthlyRevenueReportDto> MonthlyRevenue { get; set; } = [];
        public IEnumerable<TopItemReportDto> TopItems { get; set; } = [];
    }

    public class TopCustomerDto
    {
        public string Name { get; set; } = string.Empty;
        public decimal TotalSpent { get; set; }
    }

    public class TopItemReportDto
    {
        public string CodeName { get; set; } = string.Empty;
        public int Quantity { get; set; }
        public decimal Revenue { get; set; }
    }
}
