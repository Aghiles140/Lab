output "Resource_group_name" {
  description = "Le nom du groupe de ressources crée"
  value       = azurerm_resource_group.new.name
}

output "Resource_group_id" {
  description = "L'id' du groupe de ressources crée"
  value       = azurerm_resource_group.new.id
}