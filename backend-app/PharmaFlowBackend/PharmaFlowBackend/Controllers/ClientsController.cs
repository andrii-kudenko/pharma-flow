using Microsoft.AspNetCore.Mvc;
using PharmaFlowBackend.Services;

namespace PharmaFlowBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ClientsController : ControllerBase
{
    private readonly ClientService _clientService;

    public ClientsController(ClientService clientService)
    {
        _clientService = clientService;
    }

    [HttpGet("all")]
    public async Task<IActionResult> GetAll()
    {
        var clients = await _clientService.GetAllClientsAsync();
        return Ok(clients);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(Guid id)
    {
        var client = await _clientService.GetClientByIdAsync(id);
        return client == null ? NotFound() : Ok(client);
    }
}