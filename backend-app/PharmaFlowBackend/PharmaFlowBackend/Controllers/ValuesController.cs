using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace PharmaFlowBackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetValuesAsync()
        {
            var result = new
            {
                ProductId = 1,
                Name = "Sample Product",
                Price = 19.99
            };

            return Ok(result); // <- Standard controller-style JSON response
        }
    }
}
