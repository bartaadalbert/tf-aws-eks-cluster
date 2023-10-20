output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "kubeconfig_content" {
  description = "Content of the generated kubeconfig file for the EKS cluster."
  value       = module.eks-kubeconfig.kubeconfig
  sensitive   = true
}
