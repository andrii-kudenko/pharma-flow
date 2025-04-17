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

    }
}
