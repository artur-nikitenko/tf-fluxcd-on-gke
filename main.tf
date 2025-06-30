terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  backend "gcs" {
    bucket = "tf-fluxcd-on-gke-bucket"
    prefix = "tf-fluxcd-on-gke"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}

module "gke_cluster" {
  source           = "github.com/artur-nikitenko/tf-google-gke-cluster"
  GOOGLE_PROJECT   = var.project_id
  GOOGLE_REGION    = var.region
  GKE_MACHINE_TYPE = var.gke_machine_type
  GKE_NUM_NODES    = var.gke_num_nodes
  GKE_DISK_SIZE    = var.gke_disk_size
}

module "tls_keys" {
  source = "github.com/den-vasyliev/tf-hashicorp-tls-keys"
}

module "flux_repo" {
  source                  = "github.com/den-vasyliev/tf-github-repository"
  github_owner            = var.github_owner
  github_token            = var.github_token
  repository_name         = var.repo_name
  public_key_openssh      = module.tls_keys.public_key_openssh
  public_key_openssh_title = "flux"
}

module "flux_bootstrap" {
  source            = "github.com/artur-nikitenko/tf-fluxcd-flux-bootstrap"

  github_repository = "${var.github_owner}/${var.repo_name}"
  #github_token      = var.github_token
  private_key       = module.tls_keys.private_key_pem
  config_path       = pathexpand("~/.kube/config")

}
