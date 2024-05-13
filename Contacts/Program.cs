using Microsoft.EntityFrameworkCore;
using Contacts.Data;
using Azure.Security.KeyVault.Secrets;
using Azure.Identity;

const string DEV_ENVIRONMENT = "dev";

var builder = WebApplication.CreateBuilder(args);

var env = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? DEV_ENVIRONMENT;
var keyvaultUrl = builder.Configuration["KEYVAULT_URL"] ?? throw new Exception("Keyvault url not found");

// For some reason, I keep seeing "development" when running EF Core
if (env.Equals("development", StringComparison.CurrentCultureIgnoreCase))
{
    env = DEV_ENVIRONMENT;
}

var secretClient = new SecretClient(new Uri(keyvaultUrl),
    new DefaultAzureCredential());
var secret = await secretClient.GetSecretAsync("sqlconnectionstring");
var sqlConnectionString = secret.Value.Value;

builder.Services.AddDbContext<ModelStateErrorContext>(options =>
   options.UseSqlServer(sqlConnectionString));

builder.Services.AddControllersWithViews();

var app = builder.Build();

if (app.Environment.EnvironmentName == DEV_ENVIRONMENT)
{
    app.UseDeveloperExceptionPage();
}
else
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Contacts}/{action=Index}/{id?}");

app.Run();
