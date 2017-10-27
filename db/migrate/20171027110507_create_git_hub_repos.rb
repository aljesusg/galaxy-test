class CreateGitHubRepos < ActiveRecord::Migration[5.1]
  def change
    create_table :git_hub_repos do |t|
      t.string :name
      t.string :full_name
      t.string :description
      t.string :homepage
      t.string :ssh_url
      t.string :clone_url
      t.string :html_url
      t.integer :forks_count
      t.integer :stargazers_count
      t.integer :watchers_count
      t.datetime :gh_created_at
      t.datetime :gh_pushed_at
      t.datetime :gh_updated_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
