provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "ngnix_ingress" {
  name        = "nginx-ingress-production"
  chart       = "ingress-nginx"
  repository  = "https://kubernetes.github.io/ingress-nginx"
  version     = "3.33.0"

  set {
    name = "rbac.create"
    value = true
  }

  set {
    name = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name = "controller.publishService.enabled"
    value = true
  }

  set {
    name = "controller.replicaCount"
    value = "3"
  }
}