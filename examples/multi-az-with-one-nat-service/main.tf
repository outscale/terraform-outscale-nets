module "terraform_outscale_nets" {
  source = "git@github.com:outscale/terraform-outscale-nets.git"

  # Required variables
  osc_region     = var.osc_region
  osc_access_key = var.osc_access_key
  osc_secret_key = var.osc_secret_key

  name                           = "my-vpc"
  cidr                           = "10.0.0.0/16"
  public_subnets                 = [{ cidr = "10.0.100.0/24", az = "a" }, { cidr = "10.0.101.0/24", az = "b" }, { cidr = "10.0.102.0/24", az = "c" }]
  private_subnets                = [{ cidr = "10.0.0.0/24", az = "a" }, { cidr = "10.0.1.0/24", az = "b" }, { cidr = "10.0.2.0/24", az = "c" }]
  nat_service_per_private_subnet = false

  tags = [
    {
      key   = "vpc"
      value = "my-vpc"
    }
  ]
}
