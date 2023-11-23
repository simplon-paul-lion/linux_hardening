# Durcir une distribution Redhat 8.8

## Sommaire

### Les dépots

#### main_terraform

Ce dépot contient tous les codes des modules terraform nécessaires au déployement de l'infrastructure

#### Linux_hardening

Ce dépot contient :
- Terraform
- - main.tf => appelle les différents modules du dépot main_terraform
- - backend.tf => désigne le lieu de stockage des tfstate
- - providers.tf => définit les providers utilisés (azurerm et ansible)
- - variables.tf => permet de personnaliser le déployement

- ansible :
    - roles :
                contient les différents roles ansible nécessaire au durcissement de la distribution Redhat 8.8 selon les recommandations ANSSI (recommandation minimales)
        - ansible.cfg => définit le nom de l'inventory utilisé, désactive la        validation de la première connexion ssh, établit les différents plug-in à charger pour les utiliser
        - azure_rm.yaml => inventory dynamique
        - requirements.yaml => définit les collections à charger
        - playbook.yaml => liste et ordonnancement des roles ansible à appliquer
    - audit_reports => stocke le fichier rapport de SCAP
  
## Liste des recommandations minimales à appliquer

- R30 Désactiver lex comptes utilisateurs inutilisés
- R31 Utiliser des mots de passe robustes
- R53 2viter les fichiers ou répertoires sans utilisateurs ou sans groupe connu
- R54 Activer le sticky bit sur les répertoires inscriptibles
- R56 Eviter l'usage d'exécutables avec les droits spéciaux setuid et setgid
- R58 N'installer que les paquets strictement nécessaires
- R59 Utiliser des dépôts de paquet de confiance
- R61 Effectuer des mises à jour régulières
- R62 Désactiver les services non nécessaires
- R68 Protéger les mots de passe stockés
- R80 Réduire la surface d'attaque des services réseaux

Le dépot suivant [redhat GitHub repo](https://github.com/RedHatOfficial/ansible-role-rhel8-anssi_bp28_enhanced/blob/master/tasks/main.yml) contient l'ensemble des rôles pour le durcissement minimal de Redhat 8.8

## Déployement

L'utilisation du provisionner ansible dans terraform permet d'automatiser l'application des rôles ansibles.

```Bash
terraform init -upgrade
terraform plan
terrafor apply
```

## Le résultats

### Déploiement de l'infrastructure

- un groupe de ressource
- un vnet
- un subnnet
- carte réseau avec une adresse IP privée
- une adresse IP publique
- un groupe de sécurité réseau
- une association entre le groupe se sécurité réseau la carte réseau
- une machine virtuelle avec comme OS une distribution Redhat 8.8

### Management de la VM

Dans un même temps, Terraform utilise le provisionner Ansible et joue le playbook désigné. Installation de SCAP, application des différentes recommandations, édition du rapport par SCAP

### Le rapport

A la fin du déploiement, nous retrouvons le rapport édité par SCAP dans le répertoire audit_reports