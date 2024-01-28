output "resource_group_name" {
  value = azurerm_resource_group.RG01.name
}

output "public_ip_address" {
  description = "The actual ip address allocated for the resource."
  value       = "${azurerm_public_ip.RG01.*.ip_address}"
}

#output "public_ip_dns_name" {
#  description = "fqdn to connect to the first vm provisioned."
#  value       = "${azurerm_public_ip.RG01.*.fqdn}"
#}

#inventory file creation and assignment 
variable "filename" {
  default = ["./inventory"]
  type = list(string)
}
#Export public address to inveotory file
resource "local_file" "save_inventory" {
  content  = "${join("\n", "${azurerm_public_ip.RG01.*.ip_address}")}"
  for_each = toset(var.filename)
  filename = each.key
 }

