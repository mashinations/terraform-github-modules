locals {
  date = formatdate("YYYYMMDD", timestamp())
}

resource "random_string" "id" {
  length  = 8
  special = false
  upper   = false
}
