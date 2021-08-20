terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.13.0"
    }
  }
}

variable liuandliu_token {
  type        = string
  description = "description"
}


provider "github" {
    owner = "liuandliu"
    token = var.liuandliu_token
}

resource "github_repository" "test" {
    name = "experiment-GHA"

    lifecycle {
        ignore_changes = [
            allow_merge_commit,
            allow_rebase_merge,
            allow_squash_merge,
            has_downloads,
            has_issues,
            has_projects,
            has_wiki,
        ]
    }
}

data "github_actions_public_key" "example_public_key" {
  repository = github_repository.test.name
}

output "public_key" {
    value = data.github_actions_public_key.example_public_key
}

resource "github_actions_secret" "secret_test" {
    repository = github_repository.test.name
    secret_name = "test"
    encrypted_value = "ykaUjBBif/vnCXjxD0D2fkYStjDEbduOCTGNdziVzSvMByjzuIw3unL1QLVZeOODQ8wQQA=="
}

resource "github_actions_secret" "secret_test_2" {
    repository = github_repository.test.name
    secret_name = "test2"
    plaintext_value = "test2"
}