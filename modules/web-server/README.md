<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.dev](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_iam_instance_profile.instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_launch_configuration.dev](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_lb_listener_rule.external_forwarder_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.web_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.external_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_account_alias.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_account_alias) | data source |
| [aws_iam_policy_document.ec2_role_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_wildcard_arn"></a> [acm\_wildcard\_arn](#input\_acm\_wildcard\_arn) | n/a | `string` | `""` | no |
| <a name="input_available_zones"></a> [available\_zones](#input\_available\_zones) | n/a | `list(string)` | n/a | yes |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | Name of the company | `string` | `"Change this to the client"` | no |
| <a name="input_create_load_balancer"></a> [create\_load\_balancer](#input\_create\_load\_balancer) | whether to create resource | `bool` | `true` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Desired number of Autoscaling Groups | `number` | `3` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `"tools"` | no |
| <a name="input_external_lb_listener_arn"></a> [external\_lb\_listener\_arn](#input\_external\_lb\_listener\_arn) | Listener arn for the external load balancer | `string` | `""` | no |
| <a name="input_external_lb_name"></a> [external\_lb\_name](#input\_external\_lb\_name) | Name of external load balancer | `string` | `"medium-lb"` | no |
| <a name="input_external_lb_security_group_id"></a> [external\_lb\_security\_group\_id](#input\_external\_lb\_security\_group\_id) | Security group of external load balancer | `string` | n/a | yes |
| <a name="input_external_lb_zone_id"></a> [external\_lb\_zone\_id](#input\_external\_lb\_zone\_id) | Zone ID of external load balancer | `string` | n/a | yes |
| <a name="input_external_target_group_arns"></a> [external\_target\_group\_arns](#input\_external\_target\_group\_arns) | n/a | `list(string)` | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | type of instance | `string` | `"t2.micro"` | no |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | ARN of KMS key used by cloudwatch used in session manager | `string` | `"*"` | no |
| <a name="input_lb_ingress_rules"></a> [lb\_ingress\_rules](#input\_lb\_ingress\_rules) | allowed ips to web-server | `list(string)` | <pre>[<br>  "null"<br>]</pre> | no |
| <a name="input_log_expire_days"></a> [log\_expire\_days](#input\_log\_expire\_days) | value | `number` | `7` | no |
| <a name="input_max"></a> [max](#input\_max) | Maximum number of autoscaling group instances | `number` | `6` | no |
| <a name="input_min"></a> [min](#input\_min) | Minimum number of autoscaling groups instances | `number` | `3` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | ID of the private subnet | `list(string)` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | `"Medium"` | no |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | ID of the subnet subnet | `list(string)` | n/a | yes |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | n/a | `string` | `""` | no |
| <a name="input_service"></a> [service](#input\_service) | Service name | `string` | `"web-server"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asg_arn"></a> [asg\_arn](#output\_asg\_arn) | ################################################################### #                          Output                                ## ################################################################### |
<!-- END_TF_DOCS -->