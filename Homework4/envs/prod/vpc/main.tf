module "vpc" {
  source  = "benbense/vpc/aws"
  version = "1.0.0"
  # Variables are given by the workspace's variables input
}

module "ec2" {
  source  = "benbense/ec2/aws"
  version = "1.0.0"
  # Variables are given by the workspace's variables input
}
