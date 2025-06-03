variable "env" {
    description = "Le nom de l'environnement ( ex : Prod, Dev, test ....) "
    type        = string
}

variable "project" { 
    description = "Le nom du projet (ex : Energx) "
    type        = string
}

variable "location" {
    description = "La region ou le groupe de ressource sera hebergé"
    type        = string
    default     = "France Central"
}