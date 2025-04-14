using Microsoft.EntityFrameworkCore;
using PharmaFlowBackend.Data;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
//builder.Services.AddOpenApi();
builder.Services.AddDbContext<AppDbContext>(options => options.UseNpgsql("Host=dpg-cvm53mpr0fns7380krq0-a.oregon-postgres.render.com;Port=5432;Database=pharmaflow;Username=pharmaflow_user;Password=pPTucvAdn67V6zUrWoE5EoKzxjLrgRuT;Ssl Mode=Require;Trust Server Certificate=true"));
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddControllers();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

if (!app.Environment.IsDevelopment())
{
    app.UseHttpsRedirection();
}

app.MapControllers();

app.MapGet("/", (AppDbContext db) =>
    Results.Json(new
    {
        ProductId = 1,
        Name = "Sample Product",
        Price = 19.99
    }));

app.Run();