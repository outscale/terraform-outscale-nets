module "terraform_outscale_nets" {
  source = "git@github.com:outscale/terraform-outscale-nets.git"

  # Required variables
  osc_region     = var.osc_region
  osc_access_key = var.osc_access_key
  osc_secret_key = var.osc_secret_key

  name                           = "my-vpc"
  cidr                           = "10.0.0.0/16"
  public_subnets                 = [{ cidr = "10.0.100.0/24", az = "a" }]
  private_subnets                = [{ cidr = "10.0.0.0/24", az = "a" }]
  nat_service_per_private_subnet = false

  tags = [
    {
      key   = "vpc"
      value = "my-vpc"
    }
  ]
}
