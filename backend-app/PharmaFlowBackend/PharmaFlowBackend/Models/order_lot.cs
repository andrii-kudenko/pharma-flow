using System;
using System.Collections.Generic;

namespace PharmaFlowBackend.Models;

public partial class order_lot
{
    public Guid id { get; set; }

    public Guid? order_id { get; set; }

    public Guid lot_id { get; set; }

    public int quantity { get; set; }

    public DateTime? created_at { get; set; }

    public virtual lot lot { get; set; } = null!;

    public virtual order? order { get; set; }
}
