variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "zone" {
  type    = string
  default = "europe-west1-b"
}

variable "ssh_user" {
  type    = string
  default = "ansible"
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "web_port" {
  type    = number
  default = 8080
}

variable "api_port" {
  type    = number
  default = 5000
}
