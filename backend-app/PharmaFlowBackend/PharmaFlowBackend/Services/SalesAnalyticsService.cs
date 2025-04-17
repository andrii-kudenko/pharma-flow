using Microsoft.EntityFrameworkCore;
using PharmaFlowBackend.Data;
using PharmaFlowBackend.DTO;
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





    }
}
