namespace PharmaFlowBackend.DTOs
{
    public class MonthlyQuantityDto
    {
        public string Key { get; set; } = string.Empty; // "January", "February", ...
        public int Value { get; set; } // total quantity sold
    }

}
