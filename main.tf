terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.13.0"
    }
  }
}

provider "github" {
  owner = "LiuAndLiu"
}

resource "github_repository" "experiment-gha" {
    name = "template"
    auto_init = true
}

resource "github_branch_protection" "main" {
    repository_id = github_repository.experiment-gha.node_id
  # also accepts repository name
  # repository_id  = github_repository.example.name

  pattern          = "main"
  enforce_admins   = true
  allows_deletions = true

  required_status_checks {}

  push_restrictions = []

  dynamic "required_pull_request_reviews" {
    for_each = []
    content {
      required_approving_review_count = 1
    }
  }
  
}