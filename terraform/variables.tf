variable "environment"         { type = string }
variable "location"            { type = string }
variable "resource_group_name" { type = string }
variable "vnet_name"           { type = string }
variable "db_subnet_name"      { type = string }
variable "dns_zone_id"         { type = string }
variable "db_name"             { type = string }
variable "db_username"         { type = string }

variable "db_password" {
  type      = string
  sensitive = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
