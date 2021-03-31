variable "location" {
  type    = string
  default = "northcentralus"
}

variable "db_table_name" {
  type    = string
  default = "terraform-learn"
}

variable "through" {
  type = number
  default = 400
}