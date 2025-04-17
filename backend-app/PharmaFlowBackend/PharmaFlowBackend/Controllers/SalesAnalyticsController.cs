using Microsoft.AspNetCore.Mvc;
using PharmaFlowBackend.Services;

namespace PharmaFlowBackend.Controllers
{
    public class SalesAnalyticsController : Controller
    {
        private readonly SalesAnalyticsService _service;
        public SalesAnalyticsController(SalesAnalyticsService service)
        {
            _service = service;
        }
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet("monthly-revenue")]
        public async Task<IActionResult> GetMonthlyRevenue([FromQuery] int? year)
        {
            var data = await _service.GetMonthlyRevenueAsync(year);
            return Ok(data);
        }

        [HttpGet("top-items")]
        public async Task<IActionResult> GetTopItemsByRevenue([FromQuery] int year, [FromQuery] int top = 5)
        {
            var result = await _service.GetTopItemsByRevenueAsync(year, top);
            return Ok(result);
        }

        [HttpGet("monthly-quantity")]
        public async Task<IActionResult> GetMonthlyQuantity([FromQuery] int? year)
        {
            var result = await _service.GetMonthlyItemQuantitiesAsync(year);
            return Ok(result);
        }
        [HttpGet("top-items-quantity")]
        public async Task<IActionResult> GetTopItemsByQuantity([FromQuery] int year, [FromQuery] int top = 5)
        {
            var result = await _service.GetTopItemsByQuantityAsync(year, top);
            return Ok(result);
        }
        [HttpGet("high-value-cutomers")]
        public async Task<IActionResult> GetHighValueCustomers([FromQuery] int year)
        {
            var result = await _service.GetHighValueCustomersByYearAsync(year);
            return Ok(result);
        }

    }
}
