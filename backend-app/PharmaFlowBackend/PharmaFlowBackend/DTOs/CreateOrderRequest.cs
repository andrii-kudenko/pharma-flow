namespace PharmaFlowBackend.DTOs;

public class CreateOrderRequest
{
    public Guid client_id { get; set; }
    public List<ItemQuantityRequest> items { get; set; } = new();
}

public class ItemQuantityRequest
{
    public Guid item_id { get; set; }
    public int quantity { get; set; }
}


