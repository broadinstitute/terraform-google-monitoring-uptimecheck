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
