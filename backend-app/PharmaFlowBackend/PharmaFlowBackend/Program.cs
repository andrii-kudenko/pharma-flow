using Microsoft.EntityFrameworkCore;
using Npgsql;
using PharmaFlowBackend.Data;
using PharmaFlowBackend.Models;
using PharmaFlowBackend.Services;
using static Npgsql.NpgsqlConnection;


//var builder = WebApplication.CreateBuilder(args);

var dataSourceBuilder = new NpgsqlDataSourceBuilder("Host=dpg-cvm53mpr0fns7380krq0-a.oregon-postgres.render.com;Port=5432;Database=pharmaflow;Username=pharmaflow_user;Password=pPTucvAdn67V6zUrWoE5EoKzxjLrgRuT;Ssl Mode=Require;Trust Server Certificate=true");
NpgsqlConnection.GlobalTypeMapper.MapEnum<OrderStatus>("order_status");
await using var dataSource = dataSourceBuilder.Build();

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContext<AppDbContext>(options =>
{
    _ = options.UseNpgsql(dataSource);
});

// Add services to the container.
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
//builder.Services.AddOpenApi();
//builder.Services.AddDbContext<AppDbContext>(options => options.UseNpgsql("Host=dpg-cvm53mpr0fns7380krq0-a.oregon-postgres.render.com;Port=5432;Database=pharmaflow;Username=pharmaflow_user;Password=pPTucvAdn67V6zUrWoE5EoKzxjLrgRuT;Ssl Mode=Require;Trust Server Certificate=true"));
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddControllers().AddJsonOptions(options =>
{
    options.JsonSerializerOptions.Converters.Add(new DateTimeJsonConverter());
});
builder.Services.AddControllers();
builder.Services.AddScoped<ItemService>();
builder.Services.AddScoped<OrderService>();
builder.Services.AddScoped<SalesAnalyticsService>();

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowReactApp", builder =>
    {
        builder.WithOrigins("http://localhost:3000") // Replace with your React app's URL
            .AllowAnyHeader()
            .AllowAnyMethod();
    });
    
    
    
});


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

app.UseCors("AllowReactApp");
app.MapControllers();

//app.MapGet("/", (AppDbContext db) =>
//    Results.Json(new
//    {
//        ProductId = 1,
//        Name = "Sample Product",
//        Price = 19.99
//    }));

app.Run();


