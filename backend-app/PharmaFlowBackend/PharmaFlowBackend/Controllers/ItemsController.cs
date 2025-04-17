using Microsoft.AspNetCore.Mvc;
using PharmaFlowBackend.DTOs;
using PharmaFlowBackend.Models;
using PharmaFlowBackend.Services;

namespace PharmaFlowBackend.Controllers;

[ApiController]
[Route("api/items")]
public class ItemsController : ControllerBase
{
    //using Item Service
    private readonly ItemService _itemService;
    
    //item service injection
    public ItemsController(ItemService itemService)
    {
        _itemService = itemService;
    }
    
    //for client side use 
    [HttpGet]
    public async Task<ActionResult<IEnumerable<item>>> GetAllItemsWithStock()
    {
        var items = await _itemService.GetAllItemsWithStockAsync();
        return Ok(items);
    }
    
    //for cient side use
    [HttpGet("{id}")]
    public async Task<IActionResult> GetItemWithStockById(Guid id)
    {
        var item = await _itemService.GetItemWithStockByIdAsync(id);
        if (item == null) return NotFound();

        return Ok(item);
    }
}