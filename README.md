
- [Description of the Project](#description-of-the-project)
	- [Set up AWS credentials](#set-up-aws-credentials)
	- [Main Tutorial](#main-tutorial)

## Description of the Project
This Terragrunt project creates a VPC, Load balancer, Security groups and web-server 

### Set up AWS credentials
If you haven't already set up your credentials, follow this guide or the [official AWS documentation](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html)

	$ cd ~/.aws
	$ nano credentials

	[terragrunt]
	aws_access_key_id     = <ACCESS_KEY_ID>
	aws_secret_access_key = <SECRET_ACCESS_KEY>

Replace the placeholders with your own values created from creating a new IAM account. You can change <terragrunt> to something of your preference

### Main Tutorial
If you have already set up your credentials as environment variables, 

  1. Add you own IP to:
   
        -  `medium/eu-west-1/infastructure/external-security/terragrunt.hcl` - line 32 -   ingress_cidr_blocks = concat(["<ADD_YOUR_OWN_IP_HERE>/32"])

        #### Example
        Before 
        ingress_cidr_blocks = concat(["/32"])

        After
        ingress_cidr_blocks = concat(["10.0.0.0/32"])


        -  `medium/eu-west-1/services/web-server/terragrunt.hcl` - line 45 - 	lb_ingress_rules = ["ADD_YOUR_OWN_IP_HERE/32"]

        -   `medium/eu-west-2/infastructure/external-security/terragrunt.hcl` - line 32
        -    `medium/eu-west-2/services/web-server/terragrunt.hcl` - line 45


1. Check the contents of the directory and print working directory 


		$ ls       

		Medium         README.md      git.md         modules        terragrunt.hcl    

		$ pwd     
		/Users/man-waitse/Documents/terragrunt-medium

2. Export AWS Profile    
   
		$ export AWS_PROFILE=terragrunt

3. Run the following Terragrunt command to `terraform apply on all subfolders`.

		$ terragrunt run-all apply 

		Group 1
		- Module /Users/man-waitse/Documents/terragrunt-medium/Medium/eu-west-1/infrastructure/vpc
		- Module /Users/man-waitse/Documents/terragrunt-medium/Medium/eu-west-2/infrastructure/vpc

		Group 2
		- Module /Users/man-waitse/Documents/terragrunt-medium/Medium/eu-west-1/infrastructure/load-balancer/external-security-group
		- Module /Users/man-waitse/Documents/terragrunt-medium/Medium/eu-west-2/infrastructure/load-balancer/external-security-group

		Group 3
		- Module /Users/man-waitse/Documents/terragrunt-medium/Medium/eu-west-1/infrastructure/load-balancer/external-alb
		- Module /Users/man-waitse/Documents/terragrunt-medium/Medium/eu-west-2/infrastructure/load-balancer/external-alb

		Group 4
		- Module /Users/man-waitse/Documents/terragrunt-medium/Medium/eu-west-1/services/web-server
		- Module /Users/man-waitse/Documents/terragrunt-medium/Medium/eu-west-2/services/web-server

		Are you sure you want to run 'terragrunt apply' in each folder of the stack described above? (y/n) 

		$ y 
