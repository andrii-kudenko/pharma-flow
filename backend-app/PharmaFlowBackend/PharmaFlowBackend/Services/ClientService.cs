using PharmaFlowBackend.Data;
using PharmaFlowBackend.DTOs;
using Microsoft.EntityFrameworkCore;
using PharmaFlowBackend.Models;

namespace PharmaFlowBackend.Services;

public class ClientService
{
    private readonly AppDbContext _db;

    public ClientService(AppDbContext db)
    {
        _db = db;
    }

    public async Task<List<ClientSummaryDto>> GetAllClientsAsync()
    {
        return await _db.clients
            .Select(c => new ClientSummaryDto
            {
                id = c.id,
                name = c.f_name + " " + c.l_name,
                company_name = c.company_name,
                last_order_date = c.last_order_date
            })
            .OrderBy(c => c.name)
            .ToListAsync();
    }
    
    public async Task<ClientDetailDto?> GetClientByIdAsync(Guid id)
    {
        var client = await _db.clients.FirstOrDefaultAsync(c => c.id == id);
        if (client == null) return null;

        return new ClientDetailDto
        {
            id = client.id,
            f_name = client.f_name,
            l_name = client.l_name,
            email = client.email,
            phone = client.phone,
            company_name = client.company_name,
            orders_count = client.orders_count,
            delivery_address = client.delivery_address,
            billing_address = client.billing_address
        };
    }
}