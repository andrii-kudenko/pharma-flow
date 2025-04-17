using System;
using System.Collections.Generic;

namespace PharmaFlowBackend.Models;

public partial class item
{
    public Guid id { get; set; }

    public string code_name { get; set; } = null!;

    public string? ref_number { get; set; }

    public string? gtin { get; set; }

    public string manufacturer { get; set; } = null!;

    public string? description { get; set; }

    public string? official_url { get; set; }

    public DateTime? created_at { get; set; }

    public bool? can_be_ordered { get; set; }

    public decimal price_usd { get; set; }

    public virtual ICollection<lot> lots { get; set; } = new List<lot>();
}
