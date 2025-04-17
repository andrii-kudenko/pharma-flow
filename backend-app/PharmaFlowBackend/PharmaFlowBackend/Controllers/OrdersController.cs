using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PharmaFlowBackend.Data;
using PharmaFlowBackend.DTOs;
using PharmaFlowBackend.Models;
using PharmaFlowBackend.Services;

namespace PharmaFlowBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrdersController : ControllerBase
    {
        private readonly AppDbContext _db;
        private readonly OrderService _orderService;
        public OrdersController(AppDbContext db, OrderService orderService)
        {
            _db = db;
            _orderService = orderService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            return Ok(await _db.orders.ToListAsync());
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(Guid id)
        {
            var order = await _db.orders.FindAsync(id);
            return order == null ? NotFound() : Ok(order);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateOrderRequest request)
        {
            try
            {
                var created = await _orderService.CreateOrderAsync(request);

                var result = new OrderConfirmationDTO
                {
                    id = created.id,
                    order_number = created.order_number,
                    total_items = created.total_items,
                    created_at = created.created_at 
                };

                return CreatedAtAction(nameof(GetById), new { id = result.id }, result);
            }
            catch (InvalidOperationException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { error = "Internal server error", detail = ex.Message });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(Guid id, order updated)
        {
            if (id != updated.id) return BadRequest();

            _db.Entry(updated).State = EntityState.Modified;
            await _db.SaveChangesAsync();
            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var order = await _db.orders.FindAsync(id);
            if (order == null) return NotFound();

            _db.orders.Remove(order);
            await _db.SaveChangesAsync();
            return NoContent();
        }
        
        
        [HttpGet("all")]
        public async Task<IActionResult> GetAllOrders()
        {
            var orders = await _orderService.GetAllOrdersAsync();
            return Ok(orders);
        }

        [HttpGet("details/{id}")]
        public async Task<IActionResult> GetOrderDetails(Guid id)
        {
            var order = await _orderService.GetOrderDetailsByIdAsync(id);
            return order == null ? NotFound() : Ok(order);
        }
    }
}
