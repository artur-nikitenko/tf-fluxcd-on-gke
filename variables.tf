variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west4"
}

variable "gke_machine_type" {
  description = "GKE machine type"
  type        = string
  default     = "e2-micro"
}

variable "gke_num_nodes" {
  description = "Number of GKE nodes"
  type        = number
  default     = 2
}

variable "gke_disk_size" {
  description = "Disk size for GKE nodes (in GB)"
  type        = number
  default     = 30
}

variable "github_token" {
  description = "GitHub token for managing repositories"
  type        = string
  sensitive   = true
}

variable "github_owner" {
  description = "GitHub organization or user"
  type        = string
}

variable "repo_name" {
  description = "GitHub repo for FluxCD"
  type        = string
}
