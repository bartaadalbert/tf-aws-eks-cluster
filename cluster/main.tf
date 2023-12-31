    provider "aws" {
        access_key = "${var.AWS_ACCESS_KEY}"
        secret_key = "${var.AWS_SECRET_KEY}"
        region = "${var.AWS_REGION}"
    }
     
    data "aws_eks_cluster" "cluster" {
      name = module.eks.cluster_id
    }

    data "aws_eks_cluster_auth" "cluster" {
      name = module.eks.cluster_id
    }

    data "aws_availability_zones" "available" {}

    module "vpc" {
      source  = "terraform-aws-modules/vpc/aws"
      version = "5.1.2"

      name                 = "k8s-${var.AWS_CLUSTER_NAME}-vpc"
      cidr                 = "172.16.0.0/16"
      # azs                  = data.aws_availability_zones.available.names
      azs                  = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
      private_subnets      = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
      public_subnets       = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
      enable_nat_gateway   = true
      enable_vpn_gateway   = true
      single_nat_gateway   = true
      enable_dns_hostnames = true

      public_subnet_tags = {
        "kubernetes.io/cluster/${var.AWS_CLUSTER_NAME}" = "shared"
        "kubernetes.io/role/elb"                    = "1"
      }

      private_subnet_tags = {
        "kubernetes.io/cluster/${var.AWS_CLUSTER_NAME}" = "shared"
        "kubernetes.io/role/internal-elb"           = "1"
      }
    }

    module "eks" {
      source  = "terraform-aws-modules/eks/aws"
      version = "18.30.3"

      cluster_name    = "eks-${var.AWS_CLUSTER_NAME}"
      cluster_version = "1.24"
      subnet_ids        = module.vpc.private_subnets
      vpc_id = module.vpc.vpc_id

      eks_managed_node_groups = {
        first = {
          desired_capacity = var.AWS_NUM_NODES
          max_capacity     = 10
          min_capacity     = 1

          instance_type = "${var.AWS_MACHINE_TYPE}"
        }
      }
      
      node_security_group_additional_rules = {
        ingress_allow_access_from_control_plane = {
          type                          = "ingress"
          protocol                      = "tcp"
          from_port                     = 9443
          to_port                       = 9443
          source_cluster_security_group = true
          description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
        }
      }
    }

    module "eks-kubeconfig" {
      source     = "hyperbadger/eks-kubeconfig/aws"
      version    = "1.0.0"

      depends_on = [module.eks]
      cluster_id =  module.eks.cluster_id
    }

    resource "local_file" "kubeconfig" {
      content  = module.eks-kubeconfig.kubeconfig
    #   filename = "kubeconfig_${var.AWS_CLUSTER_NAME}"
      filename = "${path.module}/kubeconfig"
    }

    resource "aws_iam_policy" "worker_policy" {
      name        = "worker-policy-${var.AWS_CLUSTER_NAME}"
      description = "Worker policy for the ALB Ingress"

      policy = file("iam-policy.json")
    }

    resource "aws_iam_role_policy_attachment" "additional" {
      for_each = module.eks.eks_managed_node_groups

      policy_arn = aws_iam_policy.worker_policy.arn
      role       = each.value.iam_role_name
    }


    provider "helm" {
      kubernetes {
        host                   = data.aws_eks_cluster.cluster.endpoint
        cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
        token                  = data.aws_eks_cluster_auth.cluster.token
        }
    }

    resource "helm_release" "ingress" {
      name       = "ingress"
      chart      = "aws-load-balancer-controller"
      repository = "https://aws.github.io/eks-charts"
      version    = "1.4.6"

      set {
        name  = "autoDiscoverAwsRegion"
        value = "true"
      }
      set {
        name  = "autoDiscoverAwsVpcID"
        value = "true"
      }
      set {
        name  = "clusterName"
        value = var.AWS_CLUSTER_NAME
      }
    }

