resource "azurerm_resource_group" "new" {
    name     = "rg-${var.env}-${var.project}"
    location = var.location

    tags = {
        Env     = var.env
        project = var.project
    }
}