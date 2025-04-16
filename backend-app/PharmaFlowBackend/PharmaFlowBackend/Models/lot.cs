using System;
using System.Collections.Generic;

namespace PharmaFlowBackend.Models;

public partial class lot
{
    public Guid id { get; set; }

    public Guid item_id { get; set; }

    public string lot_number { get; set; } = null!;

    public DateOnly expiration_date { get; set; }

    public DateOnly? manufacture_date { get; set; }

    public int quantity_available { get; set; }

    public string? certificate_url { get; set; }

    public DateTime? received_at { get; set; }

    public virtual item item { get; set; } = null!;

    public virtual ICollection<order_lot> order_lots { get; set; } = new List<order_lot>();
}
