namespace PharmaFlowBackend.DTOs;

public class ItemsDTO
{
    public Guid id { get; set; }
    public string code_name { get; set; }
    public string manufacturer { get; set; }
    public string? description { get; set; }
    public string? official_url { get; set; }
    public bool? can_be_ordered { get; set; }
    public decimal? price_usd { get; set; }

    public int available_quantity { get; set; }
}