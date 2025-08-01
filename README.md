## **terraform-outscale-nets**

[![Project Stage](https://docs.outscale.com/fr/userguide/_images/Project-Sandbox-yellow.svg)](https://docs.outscale.com/en/userguide/Open-Source-Projects.html) [![](https://dcbadge.limes.pink/api/server/HUVtY5gT6s?style=flat&theme=default-inverted)](https://discord.gg/HUVtY5gT6s)

---

## 📄 Table of Contents

- [Overview](#-overview)
- [Requirements](#-requirements)
- [Usage](#-usage)
- [Configuration](#-configuration)
- [Examples](#-examples)
- [License](#-license)
- [Contributing](#-contributing)

---

## 🧭 Overview

**terraform-outscale-nets** is a Terraform/OpenTofu module for deploying a vpc and the necessary components (subnets, internet gateway, ...).

Key features:
- public/private/storage subnets
- internet service
- nat service (one per private subnet or not)
- kubernetes tags if you want use the [Cloud provider OSC](https://github.com/outscale/cloud-provider-osc)

---

## ✅ Requirements

- Go

---

## 🚀 Usage

```hlc
module "terraform-outscale-nets" {
  source = "git@github.com:outscale/terraform-outscale-nets.git" // you can use a specific version

  --- vars ---
}
```

---

## 🛠 Configuration

You need to specify the Access Key Id and Secret Key Id in the variables or use the environment variables

---

## 💡 Examples

See [example folder](https://github.com/outscale/terraform-outscale-nets)

---

## 📜 License

**terraform-outscale-nets** is released under the < License Name > license.
© 2025 Outscale SAS
See [LICENSE](./LICENSE) for full details.

---

## 🤝 Contributing

We welcome contributions!

Please read our [Contributing Guidelines](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md) before submitting a pull request.

---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_outscale"></a> [outscale](#requirement\_outscale) | 1.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_outscale"></a> [outscale](#provider\_outscale) | 1.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [outscale_internet_service.internet_service](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/internet_service) | resource |
| [outscale_internet_service_link.internet_service_link](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/internet_service_link) | resource |
| [outscale_nat_service.private_nat_service](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/nat_service) | resource |
| [outscale_nat_service.storage_nat_service](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/nat_service) | resource |
| [outscale_net.net](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/net) | resource |
| [outscale_public_ip.nat_service_private_subnet_public_ip](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/public_ip) | resource |
| [outscale_public_ip.nat_service_storage_subnet_public_ip](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/public_ip) | resource |
| [outscale_route.private_route_to_nat_service](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/route) | resource |
| [outscale_route.route_to_internet_service](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/route) | resource |
| [outscale_route.storage_route_to_nat_service](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/route) | resource |
| [outscale_route_table.private_route_table](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/route_table) | resource |
| [outscale_route_table.public_route_table](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/route_table) | resource |
| [outscale_route_table.storage_route_table](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/route_table) | resource |
| [outscale_route_table_link.private_route_table_link](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/route_table_link) | resource |
| [outscale_route_table_link.public_route_table_link](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/route_table_link) | resource |
| [outscale_route_table_link.storage_route_table_link](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/route_table_link) | resource |
| [outscale_subnet.private_subnet](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/subnet) | resource |
| [outscale_subnet.public_subnet](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/subnet) | resource |
| [outscale_subnet.storage_subnet](https://registry.terraform.io/providers/outscale/outscale/1.2.0/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | The CIDR block for the net. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_enable_internet_service"></a> [enable\_internet\_service](#input\_enable\_internet\_service) | Whether to create an internet service. | `bool` | `true` | no |
| <a name="input_enable_private_subnets_nat_service"></a> [enable\_private\_subnets\_nat\_service](#input\_enable\_private\_subnets\_nat\_service) | Whether to enable NAT service for private subnets. | `bool` | `true` | no |
| <a name="input_enable_storage_subnets_nat_service"></a> [enable\_storage\_subnets\_nat\_service](#input\_enable\_storage\_subnets\_nat\_service) | Whether to enable NAT service for storage subnets. | `bool` | `false` | no |
| <a name="input_internet_service_tags"></a> [internet\_service\_tags](#input\_internet\_service\_tags) | A map of tags to assign to the internet service. | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#input\_kubernetes\_cluster\_name) | The name of the Kubernetes cluster. | `string` | `""` | no |
| <a name="input_kubernetes_support"></a> [kubernetes\_support](#input\_kubernetes\_support) | Whether to enable Kubernetes support. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the net. | `string` | `""` | no |
| <a name="input_nat_service_per_private_subnet"></a> [nat\_service\_per\_private\_subnet](#input\_nat\_service\_per\_private\_subnet) | Whether to create a NAT service in each subregion. | `bool` | `false` | no |
| <a name="input_nat_service_per_storage_subnet"></a> [nat\_service\_per\_storage\_subnet](#input\_nat\_service\_per\_storage\_subnet) | Whether to create a NAT service in each subregion for storage subnets. | `bool` | `false` | no |
| <a name="input_net_tags"></a> [net\_tags](#input\_net\_tags) | A map of tags to assign to the net. | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_osc_access_key"></a> [osc\_access\_key](#input\_osc\_access\_key) | The Outscale access key. | `string` | `""` | no |
| <a name="input_osc_region"></a> [osc\_region](#input\_osc\_region) | The Outscale region to use. | `string` | `"eu-west-2"` | no |
| <a name="input_osc_secret_key"></a> [osc\_secret\_key](#input\_osc\_secret\_key) | The Outscale secret key. | `string` | `""` | no |
| <a name="input_private_nat_gateway_tags"></a> [private\_nat\_gateway\_tags](#input\_private\_nat\_gateway\_tags) | A map of tags to assign to the private NAT gateways. | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_private_route_table_tags"></a> [private\_route\_table\_tags](#input\_private\_route\_table\_tags) | A map of tags to assign to the private route tables. | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_private_subnet_tags"></a> [private\_subnet\_tags](#input\_private\_subnet\_tags) | A map of tags to assign to the private subnets. | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnet CIDR blocks. | <pre>list(object({<br/>    cidr = string<br/>    az   = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "az": "a",<br/>    "cidr": "10.0.0.0/24"<br/>  },<br/>  {<br/>    "az": "b",<br/>    "cidr": "10.0.1.0/24"<br/>  },<br/>  {<br/>    "az": "c",<br/>    "cidr": "10.0.2.0/24"<br/>  }<br/>]</pre> | no |
| <a name="input_public_route_table_tags"></a> [public\_route\_table\_tags](#input\_public\_route\_table\_tags) | A map of tags to assign to the public route tables. | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | A map of tags to assign to the public subnets. | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnet CIDR blocks. | <pre>list(object({<br/>    cidr = string<br/>    az   = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "az": "a",<br/>    "cidr": "10.0.100.0/24"<br/>  },<br/>  {<br/>    "az": "b",<br/>    "cidr": "10.0.101.0/24"<br/>  },<br/>  {<br/>    "az": "c",<br/>    "cidr": "10.0.102.0/24"<br/>  }<br/>]</pre> | no |
| <a name="input_storage_nat_gateway_tags"></a> [storage\_nat\_gateway\_tags](#input\_storage\_nat\_gateway\_tags) | A map of tags to assign to the storage NAT gateways. | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_storage_route_table_tags"></a> [storage\_route\_table\_tags](#input\_storage\_route\_table\_tags) | A map of tags to assign to the storage route tables. | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_storage_subnet_tags"></a> [storage\_subnet\_tags](#input\_storage\_subnet\_tags) | A map of tags to assign to the storage subnets. | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_storage_subnets"></a> [storage\_subnets](#input\_storage\_subnets) | A list of storage subnet CIDR blocks. | <pre>list(object({<br/>    cidr = string<br/>    az   = string<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the net and its resources. | <pre>list(object({<br/>    key   = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_tenancy"></a> [tenancy](#input\_tenancy) | The tenancy of the net. Can be 'default' or 'dedicated'. | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_net_cidr_block"></a> [net\_cidr\_block](#output\_net\_cidr\_block) | The CIDR block of the Outscale Net. |
| <a name="output_net_id"></a> [net\_id](#output\_net\_id) | The ID of the Outscale Net. |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of private subnet IDs. |
| <a name="output_public_ip_for_private_nat_serivce"></a> [public\_ip\_for\_private\_nat\_serivce](#output\_public\_ip\_for\_private\_nat\_serivce) | List of public IPs for NAT service in private subnets. |
| <a name="output_public_ip_for_storage_nat_service"></a> [public\_ip\_for\_storage\_nat\_service](#output\_public\_ip\_for\_storage\_nat\_service) | List of public IPs for NAT service in storage subnets. |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of public subnet IDs. |
| <a name="output_storage_subnets"></a> [storage\_subnets](#output\_storage\_subnets) | List of storage subnet IDs. |
<!-- END_TF_DOCS -->