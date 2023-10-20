# AWS EKS Cluster Terraform Module

This module provisions an EKS cluster on AWS, along with the necessary networking components in a VPC. It also sets up AWS Load Balancer Controller on the EKS cluster.

## Prerequisites

- Terraform v0.15+ (or the version you're using)
- AWS CLI
- An AWS account with appropriate permissions

## Features

- Provisions a VPC with private and public subnets.
- Sets up an EKS cluster.
- Configures AWS Load Balancer Controller on the EKS cluster.
- Generates a kubeconfig for the provisioned EKS cluster.

## Usage

Include this module in your `main.tf` or equivalent Terraform configuration:

```hcl
module "my_eks_cluster" {
  source  = "github.com/bartaadalbert/tf-aws-eks-cluster"

  AWS_ACCESS_KEY   = var.AWS_ACCESS_KEY
  AWS_SECRET_KEY   = var.AWS_SECRET_KEY
  AWS_REGION       = var.AWS_REGION
  AWS_CLUSTER_NAME = var.AWS_CLUSTER_NAME
  AWS_TAG_NAME     = var.AWS_TAG_NAME
  AWS_MACHINE_TYPE = var.AWS_MACHINE_TYPE
  // ... include other variables as needed
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| AWS_ACCESS_KEY | AWS access key | `string` | - | yes |
| AWS_SECRET_KEY | AWS secret key | `string` | - | yes |
| AWS_REGION | AWS region | `string` | `eu-central-1` | no |
| AWS_BUCKET_NAME | S3 bucket name | `string` | - | yes |
| AWS_CLUSTER_NAME | AWS EKS cluster name | `string` | `product-web-cluster` | no |
| AWS_TAG_NAME | AWS instance tag name | `string` | `PRODUCTWEB` | no |
| AWS_MACHINE_TYPE | EC2 instance type for EKS worker nodes | `string` | `t2.micro` | no |
| AWS_NUM_NODES | Number of worker nodes | `number` | `1` | no |
| ... | ... | ... | ... | ... |

## Outputs

| Name | Description |
|------|-------------|
| eks_cluster_endpoint | Endpoint for EKS control plane |
| kubeconfig_content | Content of the generated kubeconfig file for the EKS cluster (sensitive) |


## Contributions

Contributions are welcome! If you encounter any issues or have ideas for improvements, feel free to open an issue or submit a pull request.
License
This project is licensed under the MIT License.
Feel free to further customize the README to provide more specific information about your project or any additional instructions.