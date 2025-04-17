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
    
    
    public async Task<List<OrderSummaryDto>> GetAllOrdersAsync()
    {
        return await _db.orders
            .Include(o => o.client)
            .Select(o => new OrderSummaryDto
            {
                id = o.id,
                order_number = o.order_number,
                status = o.status.ToString(),
                client_name = o.client.f_name + " " + o.client.l_name,
                company_name = o.client.company_name
            })
            .ToListAsync();
    }
    
    public async Task<OrderDetailsDto?> GetOrderDetailsByIdAsync(Guid id)
    {
        var order = await _db.orders
            .Include(o => o.client)
            .Include(o => o.order_lots)
            .ThenInclude(ol => ol.lot)
            .ThenInclude(l => l.item)
            .FirstOrDefaultAsync(o => o.id == id);

        if (order == null) return null;

        return new OrderDetailsDto
        {
            id = order.id,
            order_number = order.order_number,
            status = order.status.ToString(),
            client_name = order.client.f_name + " " + order.client.l_name,
            company_name = order.client.company_name,
            delivery_address = order.client.delivery_address,
            total_items = order.total_items,
            total_price = order.total_price,
            products = order.order_lots.Select(ol => new ProductInfo
            {
                code_name = ol.lot.item.code_name,
                description = ol.lot.item.description,
                quantity = ol.quantity,
                price_per_unit = ol.lot.item.price_usd
            }).ToList()
        };
    }
    
    public async Task<OrderStatusSummaryDto> GetOrderStatusSummaryAsync()
    {
        var currentYear = DateTime.UtcNow.Year;

        var orders = await _db.orders
            .Where(o => o.created_at >= new DateTime(currentYear, 1, 1) &&
                        o.created_at < new DateTime(currentYear + 1, 1, 1))
            .ToListAsync();

        return new OrderStatusSummaryDto
        {
            Pending = orders.Count(o => o.status == OrderStatus.Pending),
            Confirmed = orders.Count(o => o.status == OrderStatus.Confirmed),
            Shipped = orders.Count(o => o.status == OrderStatus.Shipped),
            Completed = orders.Count(o => o.status == OrderStatus.Completed)
        };
    }
    
}