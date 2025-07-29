################################################################################
# Provider
################################################################################
variable "osc_access_key" {
  description = "The Outscale access key."
  type        = string
  default     = ""
}

variable "osc_secret_key" {
  description = "The Outscale secret key."
  type        = string
  default     = ""
}

variable "osc_region" {
  description = "The Outscale region to use."
  type        = string
  default     = "eu-west-2"
}

################################################################################
# General
################################################################################

variable "tags" {
  description = "A map of tags to assign to the net and its resources."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}

################################################################################
# VPC
################################################################################
variable "name" {
  description = "The name of the net."
  type        = string
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the net."
  type        = string
  default     = "10.0.0.0/16"
}

variable "tenancy" {
  description = "The tenancy of the net. Can be 'default' or 'dedicated'."
  type        = string
  default     = "default"
}

variable "net_tags" {
  description = "A map of tags to assign to the net."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}

################################################################################
# Public subnets
################################################################################
variable "public_subnets" {
  description = "A list of public subnet CIDR blocks."
  type = list(object({
    cidr = string
    az   = string
  }))
  default = []
}

variable "public_subnet_tags" {
  description = "A map of tags to assign to the public subnets."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}

variable "public_route_table_tags" {
  description = "A map of tags to assign to the public route tables."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}

################################################################################
# Private subnets
################################################################################
variable "private_subnets" {
  description = "A list of private subnet CIDR blocks."
  type = list(object({
    cidr = string
    az   = string
  }))
  default = []
}

variable "private_subnet_tags" {
  description = "A map of tags to assign to the private subnets."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}

variable "private_route_table_tags" {
  description = "A map of tags to assign to the private route tables."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}

variable "enable_private_subnets_nat_service" {
  description = "Whether to enable NAT service for private subnets."
  type        = bool
  default     = true
}

variable "nat_service_per_private_subnet" {
  description = "Whether to create a NAT service in each subregion."
  type        = bool
  default     = false
}

variable "private_nat_gateway_tags" {
  description = "A map of tags to assign to the private NAT gateways."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}

################################################################################
# Storage subnets
################################################################################
variable "storage_subnets" {
  description = "A list of storage subnet CIDR blocks."
  type = list(object({
    cidr = string
    az   = string
  }))
  default = []
}

variable "storage_subnet_tags" {
  description = "A map of tags to assign to the storage subnets."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}

variable "storage_route_table_tags" {
  description = "A map of tags to assign to the storage route tables."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}

variable "enable_storage_subnets_nat_service" {
  description = "Whether to enable NAT service for storage subnets."
  type        = bool
  default     = false
}

variable "nat_service_per_storage_subnet" {
  description = "Whether to create a NAT service in each subregion for storage subnets."
  type        = bool
  default     = false
}

variable "storage_nat_gateway_tags" {
  description = "A map of tags to assign to the storage NAT gateways."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}

################################################################################
# Internet service
################################################################################
variable "enable_internet_service" {
  description = "Whether to create an internet service."
  type        = bool
  default     = true
}

variable "internet_service_tags" {
  description = "A map of tags to assign to the internet service."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}

################################################################################
# Kubernetes option
# This is an optional variable to enable Kubernetes support and add the necessary tags to the resources.
################################################################################
variable "kubernetes_support" {
  description = "Whether to enable Kubernetes support."
  type        = bool
  default     = false
}

variable "kubernetes_cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
  default     = ""
}