variable "project" {
  description = "Name of the GCP project"
  type        = string
}

variable "host" {
  description = "The target host for uptime check."
  type        = string
}

variable "path" {
  description = "The target path for uptime check."
  type        = string
}

variable "timeout" {
  description = "The response timeout threshold for uptime check."
  type        = string
  default     = "10s"
}

variable "notification_channels" {
  description = "List of notification_channels."
  type        = list(string)
}

variable "regions" {
  description = "The target regions for uptime check."
  type        = list(string)
  default = [
    "ASIA_PACIFIC",
    "EUROPE",
    "SOUTH_AMERICA",
    "USA",
  ]
}

variable "dependencies" {
  # See: https://github.com/hashicorp/terraform/issues/21418#issuecomment-495818852
  type        = any
  default     = []
  description = "Work-around for Terraform 0.12's lack of support for 'depends_on' in custom modules."
}

variable "enable" {
  type        = bool
  description = "Enable flag for this module. If set to false, no resources will be created."
  default     = true
}
