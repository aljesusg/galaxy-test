class AddColumnToGitHubRepos < ActiveRecord::Migration[5.1]
  def change
    add_column :git_hub_repos, :gh_id, :integer
    add_column :git_hub_repos, :fork, :boolean
    add_column :git_hub_repos, :archived, :boolean
    add_column :git_hub_repos, :open_issues_count, :integer
    add_column :git_hub_repos, :default_branch, :string
    add_column :git_hub_repos, :issues_url, :string
    add_column :git_hub_repos, :owner_login, :string
  end
end
