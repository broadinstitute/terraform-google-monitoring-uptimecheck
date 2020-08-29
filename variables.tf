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

variable "notification_channels" {
  description = "List of notification_channels."
  type        = list(string)
}
