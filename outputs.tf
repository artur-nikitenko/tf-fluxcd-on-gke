output "flux_git_repo_url" {
  value = "git@github.com:${var.github_owner}/${var.repo_name}.git"
}

output "gke_cluster_name" {
  value = module.gke_cluster.name
}

