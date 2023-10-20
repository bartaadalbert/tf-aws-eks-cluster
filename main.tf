# ************************
# terraform.statetf      #
# ************************

terraform {
    backend "s3" {
        bucket                  = "product-web-s3"
        key                     = "terraform/state"
        region                  = "eu-central-1"
        profile                 = "default"
    }
}

# ************************
# clusters               #
# ************************


module "dev_cluster" {
    source  =   "./cluster"
    AWS_CLUSTER_NAME    =   "product-web-dev"
    AWS_TAG_NAME    =   "dev-PRODUCT"
    # FLUX_GITHUB_REPO    =   "dev-aws-flux"
    AWS_MACHINE_TYPE    =   "t2.micro"
}

# module "staging_cluster" {
#     source  =   "./cluster"
#     AWS_CLUSTER_NAME    =   "product-web-stg"
#     AWS_TAG_NAME    =   "stg-PRODUCT"
#     FLUX_GITHUB_REPO    =   "stg-aws-flux"
#     AWS_MACHINE_TYPE    =   "t2.micro"
# }

# module "production_cluster" {
#     source  =   "./cluster"
#     AWS_CLUSTER_NAME    =   "product-web-prod"
#     AWS_TAG_NAME    =   "prod-PRODUCT"
#     FLUX_GITHUB_REPO    =   "prod-aws-flux"
#     AWS_MACHINE_TYPE    =   "m5.large"
# }