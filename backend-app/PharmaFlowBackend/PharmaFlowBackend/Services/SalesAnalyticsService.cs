using Microsoft.EntityFrameworkCore;
using PharmaFlowBackend.Data;
using PharmaFlowBackend.DTOs;
using PharmaFlowBackend.Models;

namespace PharmaFlowBackend.Services
{
    public class SalesAnalyticsService
    {
        private readonly AppDbContext _db;

        public SalesAnalyticsService(AppDbContext db)
        {
            _db = db;
        }
        public async Task<IEnumerable<MonthlyRevenueDto>> GetMonthlyRevenueAsync(int? year)
        {
            int targetYear = year ?? DateTime.UtcNow.Year;

            // Step 1: Fetch orders for the year
            var orders = await _db.orders
                .Where(o => o.created_at.HasValue && o.created_at.Value.Year == targetYear
                && o.status == OrderStatus.Completed)
                .ToListAsync();

            // Step 2: Group in-memory by month
            var data = orders
                .GroupBy(o => o.created_at!.Value.Month)
                .Select(g => new
                {
                    Month = g.Key,
                    Total = g.Sum(o => o.total_price)
                })
                .ToList();

            var result = Enumerable.Range(1, 12)
                .Select(m => new MonthlyRevenueDto
                {
                    Key = new DateTime(targetYear, m, 1).ToString("MMMM"),
                    Value = data.FirstOrDefault(d => d.Month == m)?.Total ?? 0
                })
                .ToList();

            return result;
        }

        public async Task<IEnumerable<ItemRevenueDto>> GetTopItemsByRevenueAsync(int year, int top = 5)
        {
            var result = await _db.order_lots
                .Join(_db.orders, ol => ol.order_id, o => o.id, (ol, o) => new { ol, o })
                .Where(x =>
        x.o.created_at.HasValue &&
        x.o.created_at.Value.Year == year &&
        x.o.status == OrderStatus.Completed) // ✅ Added status check
                .Join(_db.lots, temp => temp.ol.lot_id, l => l.id, (temp, l) => new { temp.ol, temp.o, l })
                .Join(_db.items, temp => temp.l.item_id, i => i.id, (temp, i) => new
                {
                    ItemName = i.code_name,
                    QuantitySold = temp.ol.quantity,
                    UnitPrice = i.price_usd
                })
                .GroupBy(x => x.ItemName)
                .Select(g => new ItemRevenueDto
                {
                    Key = g.Key,
                    Value = (decimal)g.Sum(x => x.QuantitySold * x.UnitPrice)
                })
                .OrderByDescending(x => x.Value)
                
                .ToListAsync();

            return result;
        }

        public async Task<IEnumerable<MonthlyQuantityDto>> GetMonthlyItemQuantitiesAsync(int? year)
        {
            int targetYear = year ?? DateTime.UtcNow.Year;

            // Step 1: Get all completed orders in that year
            var completedOrderIds = await _db.orders
                .Where(o => o.created_at.HasValue &&
                            o.created_at.Value.Year == targetYear &&
                            o.status == OrderStatus.Completed)
                .Select(o => new { o.id, o.created_at })
                .ToListAsync();

            // Step 2: Join with order_lots to get quantities and dates
            var joinedData = await _db.order_lots
                .ToListAsync();

            var monthlyQuantities = joinedData
                .Join(completedOrderIds, ol => ol.order_id, o => o.id, (ol, o) => new
                {
                    Month = o.created_at!.Value.Month,
                    Quantity = ol.quantity
                })
                .GroupBy(x => x.Month)
                .Select(g => new
                {
                    Month = g.Key,
                    TotalQuantity = g.Sum(x => x.Quantity)
                })
                .ToList();

            var result = Enumerable.Range(1, 12)
                .Select(m => new MonthlyQuantityDto
                {
                    Key = new DateTime(targetYear, m, 1).ToString("MMMM"),
                    Value = monthlyQuantities.FirstOrDefault(d => d.Month == m)?.TotalQuantity ?? 0
                })
                .ToList();

            return result;
        }

        public async Task<IEnumerable<ItemQuantityDto>> GetTopItemsByQuantityAsync(int year, int top = 5)
        {
            var result = await _db.order_lots
                .Join(_db.orders, ol => ol.order_id, o => o.id, (ol, o) => new { ol, o })
                .Where(x =>
                    x.o.created_at.HasValue &&
                    x.o.created_at.Value.Year == year &&
                    x.o.status == OrderStatus.Completed)
                .Join(_db.lots, temp => temp.ol.lot_id, l => l.id, (temp, l) => new { temp.ol, temp.o, l })
                .Join(_db.items, temp => temp.l.item_id, i => i.id, (temp, i) => new
                {
                    ItemName = i.code_name,
                    QuantitySold = temp.ol.quantity
                })
                .GroupBy(x => x.ItemName)
                .Select(g => new ItemQuantityDto
                {
                    Key = g.Key,
                    Value = g.Sum(x => x.QuantitySold)
                })
                .OrderByDescending(x => x.Value)
                
                .ToListAsync();

            return result;
        }

        public async Task<IEnumerable<HighValueCustomerDto>> GetHighValueCustomersByYearAsync(int year, int top = 10)
        {
            var result = await _db.orders
                .Where(o =>
                    o.created_at.HasValue &&
                    o.created_at.Value.Year == year &&
                    o.status == OrderStatus.Completed &&
                    o.client_id != null)
                .GroupBy(o => o.client_id)
                .Select(g => new HighValueCustomerDto
                {
                    ClientId = (Guid)g.Key,
                    CompanyName = _db.clients
                        .Where(c => c.id == g.Key)
                        .Select(c => c.company_name)
                        .FirstOrDefault(),
                    OrdersCount = g.Count(),
                    TotalSpent = g.Sum(x => x.total_price),
                    AverageOrderValue = g.Average(x => x.total_price),
                    LastOrderDate = g.Max(x => x.created_at)
                })
                .OrderByDescending(x => x.TotalSpent)
                .Take(top)
                .ToListAsync();

            return result;
        }

        public async Task<FinancialReportDto> GetFinancialReportAsync(int year)
        {
            var completedOrders = await _db.orders
                .Where(o => o.created_at.HasValue &&
                            o.created_at.Value.Year == year &&
                            o.status == OrderStatus.Completed)
                .ToListAsync();

            var totalRevenue = completedOrders.Sum(o => o.total_price);
            var totalOrders = completedOrders.Count;
            var averageOrderValue = totalOrders > 0 ? totalRevenue / totalOrders : 0;

            var itemsSold = await _db.order_lots
                .Join(_db.orders, ol => ol.order_id, o => o.id, (ol, o) => new { ol, o })
                .Where(x => x.o.created_at.HasValue &&
                            x.o.created_at.Value.Year == year &&
                            x.o.status == OrderStatus.Completed)
                .SumAsync(x => x.ol.quantity);

            var topCustomer = await _db.orders
                .Where(o => o.created_at.HasValue &&
                            o.created_at.Value.Year == year &&
                            o.status == OrderStatus.Completed)
                .GroupBy(o => o.client_id)
                .Select(g => new
                {
                    ClientId = g.Key,
                    Total = g.Sum(o => o.total_price)
                })
                .OrderByDescending(g => g.Total)
                .Take(1)
                .Join(_db.clients, g => g.ClientId, c => c.id, (g, c) => new TopCustomerDto
                {
                    Name = c.company_name,
                    TotalSpent = g.Total
                })
                .FirstOrDefaultAsync();

            var monthlyRevenue = Enumerable.Range(1, 12)
                .Select(m => new MonthlyRevenueReportDto
                {
                    Key = m,
                    Value = completedOrders
                        .Where(o => o.created_at!.Value.Month == m)
                        .Sum(o => o.total_price)
                })
                .ToList();

            var topItems = await _db.order_lots
                .Join(_db.orders, ol => ol.order_id, o => o.id, (ol, o) => new { ol, o })
                .Where(x => x.o.created_at.HasValue &&
                            x.o.created_at.Value.Year == year &&
                            x.o.status == OrderStatus.Completed)
                .Join(_db.lots, temp => temp.ol.lot_id, l => l.id, (temp, l) => new { temp.ol, l })
                .Join(_db.items, temp => temp.l.item_id, i => i.id, (temp, i) => new
                {
                    CodeName = i.code_name,
                    Quantity = temp.ol.quantity,
                    Revenue = temp.ol.quantity * i.price_usd
                })
                .GroupBy(x => x.CodeName)
                .Select(g => new TopItemReportDto
                {
                    CodeName = g.Key,
                    Quantity = g.Sum(x => x.Quantity),
                    Revenue = (decimal)g.Sum(x => x.Revenue)
                })
                .OrderByDescending(x => x.Revenue)
                .Take(5)
                .ToListAsync();

            return new FinancialReportDto
            {
                TotalRevenue = totalRevenue,
                TotalOrders = totalOrders,
                AverageOrderValue = averageOrderValue,
                ItemsSold = itemsSold,
                TopCustomer = topCustomer,
                MonthlyRevenue = monthlyRevenue,
                TopItems = topItems
            };
        }




    }
}
