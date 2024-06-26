namespace Contacts.Models;

public class Contact
{
    public int Id { get; set; }
    public string Name { get; set; } = String.Empty;
    public string ShortName { get; set; } = String.Empty;
    public string Email { get; set; } = String.Empty;
    public string PhoneNumber { get; set; } = String.Empty;
}
