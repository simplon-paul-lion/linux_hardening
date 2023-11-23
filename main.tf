module "resource_group"{
    source = "github.com/simplon-paul-lion/main-terraform/resource_group"
    name = var.name
    location = var.location

}

module "vnet" {
    source = "github.com/simplon-paul-lion/main-terraform/vnet"
    name = var.name
    resource_group_name = module.resource_group.rg.name
    location = module.resource_group.rg.location
    cidr = var.cidr
}

module "subnet"{
    source = "github.com/simplon-paul-lion/main-terraform/subnet"
    name = var.name
    address_prefixes = var.address_prefixes
    location = module.resource_group.rg.location
}

module "nsg" {
    source = "github.com/simplon-paul-lion/main-terraform/nsg"
    name = var.name
    location = module.resource_group.rg.location
}

module "public_ip" {
    source = "github.com/simplon-paul-lion/main-terraform/public_ip"
    name = var.name
    location = module.resource_group.rg.location
}

module "nic-nsg" {
  source = "github.com/simplon-paul-lion/main-terraform/nic-nsg"
  nic = module.linux_vm.nic
  nsg = module.nsg.nsg
}

module "linux_vm" {
    source = "github.com/simplon-paul-lion/main-terraform/linux_vm"
    name = var.name
    admin = var.admin
    admin_pwd = var.admin_pwd
    location = module.resource_group.rg.location
    subnet_id = module.subnet.subnet_id
    pub_id = module.public_ip.pub_id
}