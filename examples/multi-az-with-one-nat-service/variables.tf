variable "osc_region" {
  description = "The Outscale region to create resources in"
  type        = string
  default     = "eu-west-2"
}

variable "osc_access_key" {
  description = "The Outscale access key. You can use the environment variables TF_VAR_osc_access_key"
  type        = string
}

variable "osc_secret_key" {
  description = "The Outscale secret key. You can use the environment variables TF_VAR_osc_secret_key"
  type        = string
}
