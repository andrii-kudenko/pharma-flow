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
}