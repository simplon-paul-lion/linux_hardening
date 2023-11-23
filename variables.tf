variable "name" {
        default = "paul-redhat"
}

variable "admin" {
  default = "ansible"
}

variable "admin_pwd" {
  default = "QdCe2HmLf$Bt@a8HHdzK"
}

variable "location" {
    default = "westeurope"
}

variable "cidr" {
    default = ["10.0.0.0/16"]
  
}

variable "address_prefixes" {
  default =  ["10.0.1.0/24"]

}

variable "aks_node_pool_config" {
  default = {
    default = {
      name       = "default"
      node_count = 1
      vm_size    = "Standard_D2_v2"
    }
  }
}

