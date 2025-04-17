using Microsoft.EntityFrameworkCore;

namespace PharmaFlowBackend.Services;

using Data;
using Models;
using PharmaFlowBackend.DTOs;

public class OrderService
{
    private readonly AppDbContext _db;

    public OrderService(AppDbContext db)
    {
        _db = db;
    }

    public async Task<OrderConfirmationDTO> CreateOrderAsync(CreateOrderRequest request)
    {
        using var transaction = await _db.Database.BeginTransactionAsync();
        
        var newOrder = new order
        {
            id = Guid.NewGuid(),
            client_id = request.client_id,
            status = OrderStatus.Pending,
            order_number = $"ORD-{DateTimeOffset.UtcNow.ToUnixTimeSeconds()}",
            order_lots = new List<order_lot>()
        };
        
        foreach (var itemReq in request.items)
        {
            int remainingQty = itemReq.quantity;

            // Get lots for the item ordered by oldest received
            var availableLots = await _db.lots
                .Where(l => l.item_id == itemReq.item_id && l.quantity_available > 0)
                .OrderBy(l => l.received_at)
                .ToListAsync();

            foreach (var lot in availableLots)
            {
                if (remainingQty <= 0) break;

                var usedQty = Math.Min(remainingQty, lot.quantity_available);
                lot.quantity_available -= usedQty;
                remainingQty -= usedQty;

                
                newOrder.order_lots.Add(new order_lot
                {
                    id = Guid.NewGuid(),
                    order_id = newOrder.id,
                    lot_id = lot.id,
                    quantity = usedQty
                });
            }

            if (remainingQty > 0)
            {
                await transaction.RollbackAsync();
                throw new InvalidOperationException($"Not enough stock for item {itemReq.item_id}. Requested: {itemReq.quantity}, Fulfilled: {itemReq.quantity - remainingQty}");
            }
        }
        
        
        newOrder.total_items = newOrder.order_lots.Sum(ol => ol.quantity);

        _db.orders.Add(newOrder);
        await _db.SaveChangesAsync();
        await transaction.CommitAsync();

        return new OrderConfirmationDTO
        {
            id = newOrder.id,
            order_number = newOrder.order_number,
            total_items = newOrder.total_items,
            created_at = newOrder.created_at!.Value
        };
    }
}