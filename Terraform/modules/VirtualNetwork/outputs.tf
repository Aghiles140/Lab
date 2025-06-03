output "vnet_name" {
  description = "Nom de la VNet"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "IDs des sous-réseaux"
  value       = { for k, subnet in azurerm_subnet.subnets : k => subnet.id }
}

output "nsg_ids" {
  description = "IDs des NSGs"
  value       = { for k, nsg in azurerm_network_security_group.nsgs : k => nsg.id }
}
