# Homework 4
Automatically create 2 workspaces for VPC and EC2 environments.

## Workspaces Deployment
To deploy the environment navigate to [Homework4](Homework4/TFC) and run ```terrafrom apply```.

Required variables:
| Variable | Description |
| ------ | ------ |
| tfe_organization_name | Terrafrom Cloud Organization Name |
| github_user | Github Username |
| github_branch | Github Branch Name |
| availability_zones | Availability zones to account for |
| vpc_name | VPC Name |
| aws_acess_key | AWS Acess Key |
| aws_secret_acess_key | AWS Secret Acess Key |
| aws_default_region | AWS Default Region |
| cidr_size | VPC CIDR Size |
| tfe_token | Terraform Cloud API Token |
| github_pat | Github Personal Acess Token |
| bucket_name | Bucket name for ALB logs |
| instance_type | EC2 Instance type |
| instances_to_create | Number of EC2 instances to create |
| ec2_workspace_name | EC2 Workspace Name |
| vpc_workspace_name | VPC Workspace Name |

This will create 2 workspaces which should automaticlly deploy VPC and EC2 environments separately using  the following modules:
- [terraform-tfe-vpc](https://github.com/benbense/terraform-tfe-vpc)
- [terraform-tfe-ec2](https://github.com/benbense/terraform-tfe-ec2)

## TODOs
- Turn hardcoded values to variables
- Create organization automatically
- Register modules automatically to the organization

## Known Issues
- [Route tables association might fail to deploy due to timeout](https://github.com/hashicorp/terraform-provider-aws/issues/21032)
