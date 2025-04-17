namespace PharmaFlowBackend.DTOs;

public class ClientDetailDto
{
    public Guid id { get; set; }

    public string f_name { get; set; } = null!;

    public string? l_name { get; set; }

    public string? phone { get; set; }

    public string email { get; set; } = null!;

    public string company_name { get; set; } = null!;

    public string? billing_address { get; set; }

    public string? delivery_address { get; set; }

    public int? orders_count { get; set; }

    public DateOnly? last_order_date { get; set; }

    public DateTime? created_at { get; set; }

    public DateTime? updated_at { get; set; }
}