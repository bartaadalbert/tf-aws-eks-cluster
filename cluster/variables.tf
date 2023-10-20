variable "AWS_ACCESS_KEY" {
  type        = string
#   default     = "AKIXXXXXXXXXXXXXXXXXXXXX"
  description = "AWS access key"
}
variable "AWS_SECRET_KEY" {
  type        = string
#   default     = "xXX/Yyyy+xxxxxxxxxxxxxxxxxxxxxxxxxx"
  description = "AWS secret kry"
}

variable "AWS_REGION" {
  type        = string
  default     = "eu-central-1"
  description = "region name"
}

variable "AWS_BUCKET_NAME" {
  type        = string
#   default     = "product-web-s3"
  description = "s3 bucket name"
}

variable "AWS_CLUSTER_NAME" {
  type        = string
  default     = "product-web-cluster"
  description = "aws cluster name"
}

variable "AWS_TAG_NAME" {
  type        = string
  default     = "PRODUCTWEB"
  description = "aws instance tag name"
}

variable "AWS_MACHINE_TYPE" {
  type        = string
  default     = "t2.micro"
  description = "Machine type"
}
variable "AWS_MACHINE_IMAGE" {
  type        = string
  default     = "ami-06dd92ecc74fdfb36"
  description = "Machine image"
}

variable "AWS_NUM_NODES" {
  type        = number
  default     = 1
  description = "AWS nodes number"
}

# variable "GITHUB_OWNER" {
#   type        = string
#   default     = "bartaadalbert"
#   description = "My github account"
# }

# variable "GITHUB_TOKEN" {
#   type        = string
#   default     = "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
#   description = "Github access token"
#   sensitive   = true 
# }

# variable "FLUX_GITHUB_REPO" {
#   type        = string
#   default     = "flux-control-eks"
#   description = "Repo sync with flux"
# }

# variable "ARGO_GITHUB_REPO" {
#   type        = string
#   default     = "argo-control-eks"
#   description = "Repo sync with argo"
# }

# variable "app_name" {
#   description = "Name of the application"
#   type        = string
#   default     = "webapp"
# }

# variable "project_targetRevision" {
#   description = "Target revision for the application"
#   type        = string
#   default     = "develop"
# }

# variable "project_path" {
#   description = "Path to the application within the repository"
#   type        = string
#   default     = "helm"
# }

# variable "destination_namespace" {
#   description = "Namespace on the destination cluster"
#   type        = string
#   default     = "webapp-net"
# }

# variable "rsa_bits" {
#   type        = number
#   default     = 4096
#   description = "the size of the generated RSA key, in bits"
# }

# #aws ecr get-login-password --region your-region | docker login --username AWS --password-stdin your-account-id.dkr.ecr.your-region.amazonaws.com
# #cat ~/.docker/config.json
# variable "secrets" {
#   description = "Map of secret names, their types, namespaces, and key-value pairs"
#   type = map(object({
#     type      = string
#     namespace = string
#     data      = map(string)
#   }))
#   default = {
#     "ecr-pull-secret" = {
#       type      = "kubernetes.io/dockerconfigjson",
#       namespace = "your-namespace",
#       data      = {
#         ".dockerconfigjson" = <<EOT
# {
#   "auths": {
#     "your-account-id.dkr.ecr.your-region.amazonaws.com": {
#       "auth": "YOUR_BASE64_ENCODED_AUTH_TOKEN"
#     }
#   }
# }
# EOT
#     }
#   }
# }
# }
