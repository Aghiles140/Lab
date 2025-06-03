# Gestion des groupes de ressources Azure avec Terraform / Azure Devops



## Structure du Projet 📁

```bash
├── environnements/
│   ├── dev/
│   │   ├── main.tf
│   │   └── variables.tf
│   └── prod/
│       ├── main.tf
│       └── variables.tf
├── modules/
│   └── ResourceGroup/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── pipelines/
│   ├── create-rg.yml
│   └── destroy-rg.yml
├── backend.tf
├── providers.tf
└── README.md
```
## Objectif
Ce projet Terraform a pour but d’automatiser la création et la suppression de groupes de ressources Azure pour différents environnements (dev et prod), à l’aide de modules réutilisables et de pipelines CI/CD Azure DevOps.

## Technologies utilisées
- Terraform v1.3.9
- Azure DevOps Pipelines
- AzureRM Provider ~> 3.0

## Configuration Remote State
Terraform State est stocké dans le cloud dans le groupe de ressource __stracctfstate213__ afin de permettre la _collaboration_ et la _cohérence_

```hcl
terraform {
    backend "azurerm" {
      resource_group_name = "rg-dev-infra" #RG qui contient le str account
      storage_account_name = "stracctfstate213"
      container_name = "tfstate" # container pour stocker les state files
      key = terraform.tfstate #Blob qui sera crée dans le container
    }
    
}
```


## Prérequis
- Terraform Installé
- Authentification Azure CLI
- Service Principal Azure avec les autorisations necessaires
- Accés au storage account Azure pour la gestion du state
---
## Modules
### modules/ResourceGroup
Ce module gère la création d’un groupe de ressources Azure avec des tags définis :


- `env` : Environnement (dev, prod, etc.)
- `project` : Nom du projet
- `location` : Région Azure (par défaut : `France Central`)

#### 🧾 Outputs
- Resource_group_name : nom du groupe de ressources
- Resource_group_id : ID du groupe de ressources
---

## 📂 Environnements
Chaque environnement (dev et prod) possède ses propres fichiers :

- main.tf : référence au module et variables spécifiques à l'environnement
- variables.tf : déclaration des variables

## 🚀 Pipelines CI/CD
#### pipelines/create-rg.yml
Pipeline de déploiement :

- Étape __Deploy_Dev__ : déploie dans l'environnement de développement

- Étape __Deploy_Prod__ : déploie dans __prod__ uniquement si __dev__ a réussi

#### pipelines/destroy-rg.yml
Pipeline de **destruction** (à exécuter manuellement) :
- Étapes Destroy_Dev et Destroy_Prod pour supprimer les ressources respectives

##### Variables d’environnement requises (via Variable Group ```TerraformSecrets```)
- servicePrincipalId
- servicePrincipalKey
- subscriptionId
- tenantId

## Commandes Terraform utiles
#### Initialiser un environnement :
```bash
cd environnements/dev     # ou prod
terraform init
```

#### Valider et planifier :
```bash
terraform validate
terraform plan
```

#### Appliquer les changements :
```bash
terraform apply
```
#### Détruire les ressources :
```bash
terraform destroy
```

## Bonnes pratiques
- Ne jamais modifier manuellement le fichier ```terraform.tfstate```.
- Utiliser les pipelines pour les déploiements en production.
- Centraliser les secrets dans Azure DevOps (```TerraformSecrets```).
- Garder les modules génériques et réutilisables.

## Bonnes pratiques
Pour toute question ou amélioration, veuillez contacter l’équipe Infra responsable de ce projet.