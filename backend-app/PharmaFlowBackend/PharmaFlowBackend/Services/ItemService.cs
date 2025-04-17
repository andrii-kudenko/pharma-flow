using PharmaFlowBackend.DTOs;

namespace PharmaFlowBackend.Services;

using Microsoft.EntityFrameworkCore;
using PharmaFlowBackend.Data;
using PharmaFlowBackend.Models;

public class ItemService
{
    private readonly AppDbContext _db;

    public ItemService(AppDbContext db)
    {
        _db = db;
    }

    public async Task<IEnumerable<item>> GetAllItemsAsync()
    {
        return await _db.items.ToListAsync();
    }
    
    public async Task<List<ItemsDTO>> GetAllItemsWithStockAsync()
    {
        var items = await _db.items.ToListAsync();

        var result = new List<ItemsDTO>();

        foreach (var item in items)
        {
            var availableQuantity = await _db.lots
                .Where(l => l.item_id == item.id)
                .SumAsync(l => (int?)l.quantity_available) ?? 0;

            result.Add(new ItemsDTO
            {
                id = item.id,
                code_name = item.code_name,
                manufacturer = item.manufacturer,
                description = item.description,
                official_url = item.official_url,
                can_be_ordered = item.can_be_ordered,
                price_usd = item.price_usd,
                available_quantity = availableQuantity
            });
        }

        return result;
    }
    
    public async Task<ItemsDTO?> GetItemWithStockByIdAsync(Guid id)
    {
        var item = await _db.items.FindAsync(id);
        if (item == null) return null;

        var availableQuantity = await _db.lots
            .Where(l => l.item_id == id)
            .SumAsync(l => (int?)l.quantity_available) ?? 0;

        return new ItemsDTO
        {
            id = item.id,
            code_name = item.code_name,
            manufacturer = item.manufacturer,
            description = item.description,
            official_url = item.official_url,
            can_be_ordered = item.can_be_ordered,
            price_usd = item.price_usd,
            available_quantity = availableQuantity
        };
    }
}