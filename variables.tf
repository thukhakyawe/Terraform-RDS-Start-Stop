variable "tag_key" {
  description = "Tag key to identify RDS instances"
  type        = string
  default     = "AutoStartStop"
}

variable "tag_value" {
  description = "Tag value to identify RDS instances"
  type        = string
  default     = "true"
}

variable "start_schedule" {
  description = "Cron expression for starting RDS instances"
  type        = string
  default     = "cron(0 7 * * ? *)" # Every day at 07:00 UTC
}

variable "stop_schedule" {
  description = "Cron expression for stopping RDS instances"
  type        = string
  default     = "cron(0 19 * * ? *)" # Every day at 19:00 UTC
}
