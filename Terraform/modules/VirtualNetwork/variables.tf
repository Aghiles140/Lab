variable "env" {
  description = "Nom de l'environnement (ex : dev, prod)"
  type        = string
}

variable "project" {
  description = "Nom du projet"
  type        = string
}

variable "location" {
  description = "Région Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
}

variable "address_space" {
  description = "Plage d'adresses IP de la VNet"
  type        = list(string)
}

variable "subnets" {
  description = "Map des sous-réseaux avec leurs préfixes d'adresses"
  type = map(object({
    address_prefix = string
  }))
}
