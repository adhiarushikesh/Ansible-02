
output "public_ip_address" {
  description = "The actual ip address allocated for the resource."
  value       = "${azurerm_public_ip.RG01.*.ip_address}"
}

#output "public_ip_dns_name" {
#  description = "fqdn to connect to the first vm provisioned."
#  value       = "${azurerm_public_ip.RG01.*.fqdn}"
#}
data  "template_file" "inventory" {
  template = "${file("${path.module}/template/inventory.tmpl")}"
  vars = {
         #k8s_master_name = azurerm_network_security_group.toolservernsg.id
         #k8s_master_name = [for k, p in azurerm_virtual_machine.RG01: p.name]
        public_ips = "${join("\n", "${azurerm_public_ip.RG01.*.ip_address}")}"
     }
 }

 resource "local_file" "save_inventory" {
   content  = "${data.template_file.inventory.rendered}"
   filename = "./inventory"
 }