using System;
using System.Collections.Generic;

namespace PharmaFlowBackend.Models;

public partial class order
{
    public Guid id { get; set; }

    public string order_number { get; set; } = null!;

    public Guid? client_id { get; set; }
    public OrderStatus status { get; set; }

    public int total_items { get; set; }

    public DateTime? created_at { get; set; }

    public DateTime? last_updated { get; set; }

    public virtual client? client { get; set; }
    
    public decimal total_price { get; }

    public virtual ICollection<order_lot> order_lots { get; set; } = new List<order_lot>();
}

public enum OrderStatus
{
    Pending, Confirmed, Shipped, Delivered, Cancelled , Completed
}