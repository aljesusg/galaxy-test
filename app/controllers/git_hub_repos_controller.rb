class GitHubReposController < ApplicationController
  def index
    @user = params[:user_id]
    @repos = GitHubRepo.where(user: @user)

  end

  def refresh
    client = Octokit::Client.new(access_token: session["devise.github_data"]["credentials"]["token"])
    repos = client.repos
    if repos
      user = User.find(params[:user_id])
      GitHubRepo.where("user_id = ?", user.id).destroy_all
      repos.each do |ghr|
        GitHubRepo.create(name: ghr.name,
                          full_name: ghr.full_name,
                          description: ghr.description,
                          homepage: ghr.html_url,
                          ssh_url: ghr.ssh_url,
                          clone_url: ghr.clone_url,
                          html_url: ghr.html_url,
                          forks_count: ghr.forks_count,
                          stargazers_count: ghr.stargazers_count,
                          watchers_count: ghr.watchers,
                          gh_created_at: ghr.created_at,
                          gh_pushed_at: ghr.pushed_at,
                          gh_updated_at: ghr.updated_at,
                          user: user
        )
      end
    end
    redirect_to user_git_hub_repos_path
  end
end
