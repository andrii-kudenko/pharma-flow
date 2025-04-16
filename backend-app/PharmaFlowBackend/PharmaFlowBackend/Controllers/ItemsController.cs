using Microsoft.AspNetCore.Mvc;
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
    
    //getAllItems
    [HttpGet]
    [Route("getAllItems")]
    public async Task<ActionResult<IEnumerable<item>>> GetAllItems()
    {
        var items = await _itemService.GetAllItemsAsync();
        return Ok(items);
    }
}