using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PharmaFlowBackend.Data;
using PharmaFlowBackend.Models;

namespace PharmaFlowBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrdersController : ControllerBase
    {
        private readonly AppDbContext _db;
        public OrdersController(AppDbContext db)
        {
            _db = db;
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
        public async Task<IActionResult> Create(order order)
        {
            _db.orders.Add(order);
            await _db.SaveChangesAsync();
            return CreatedAtAction(nameof(GetById), new { id = order.id }, order);
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
    }
}
