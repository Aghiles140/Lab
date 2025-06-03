resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.env}-${var.project}"
  location            = var.location
  address_space       = var.address_space
  resource_group_name = var.resource_group_name

  tags = {
    environment = var.env
    project     = var.project
  }
}

# Création des sous-réseaux
resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.address_prefix]
}

# Création des NSG
resource "azurerm_network_security_group" "nsgs" {
  for_each            = var.subnets
  name                = "${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.env
    project     = var.project
  }
}

# Association des NSG aux sous-réseaux
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.nsgs[each.key].id
}