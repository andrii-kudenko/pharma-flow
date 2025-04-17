namespace PharmaFlowBackend.DTOs
{
    public class ItemQuantityDto
    {
        public string Key { get; set; } = string.Empty; // Item name
        public int Value { get; set; }                  // Total quantity sold
    }

}
