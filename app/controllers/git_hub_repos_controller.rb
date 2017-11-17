class GitHubReposController < ApplicationController
  def index
    @user = params[:user_id]
    @repos = GitHubRepo.where(user: @user)
  end

  def index_clean
    # Find the user or current_user (if not admin)
    user = if current_user.admin?
             User.find(params[:user_id])
           else
             current_user
           end
    GitHubRepo.where(user: user).destroy_all
    redirect_to user_git_hub_repos_path
  end

  def refresh
    Octokit.auto_paginate = true
    client = Octokit::Client.new(access_token: session["devise.github_data"]["credentials"]["token"])
    # Find all repos in github
    repos = client.repos
    # Find the user or current_user (if not admin)
    user = if current_user.admin?
             User.find(params[:user_id])
           else
             current_user
           end
    # Find the repos in the database, store them as an array
    user_repos = GitHubRepo.where("user_id = ?", user.id)
    # Get the list of user_id (same in github and local)
    user_repos_list = user_repos.map{ |x| x.id }
    repos_list = repos.map{ |x| x.id }


    new_repos = repos_list - user_repos_list
    deleted_repos = user_repos_list - repos_list
    updated_repos = repos_list - new_repos



    # Create new repos if they are not found
    new_repos.each do |xid|
      ghrepo = repos.find { |x| x.id == xid } # Find the original information for the repo
      GitHubRepo.create(id: ghrepo.id,
                        name: ghrepo.name,
                        full_name: ghrepo.full_name,
                        description: ghrepo.description,
                        homepage: ghrepo.homepage,
                        ssh_url: ghrepo.ssh_url,
                        clone_url: ghrepo.clone_url,
                        html_url: ghrepo.html_url,
                        forks_count: ghrepo.forks_count,
                        stargazers_count: ghrepo.stargazers_count,
                        watchers_count: ghrepo.watchers,
                        gh_created_at: ghrepo.created_at,
                        gh_pushed_at: ghrepo.pushed_at,
                        gh_updated_at: ghrepo.updated_at,
                        gh_id: ghrepo.id,
                        fork: ghrepo.fork,
                        archived: ghrepo.archived,
                        open_issues_count: ghrepo.open_issues_count,
                        default_branch: ghrepo.default_branch,
                        issues_url: ghrepo.rels[:issues].href,
                        owner_login: ghrepo.owner.login,
                        user: user)
    end

    deleted_repos.each do |xid|
      GitHubRepo.destroy(id: xid)
    end
    count_updated = 0

    updated_repos.each do |xid|
      ghrepo = repos.find { |x| x.id == xid } # Find the original information for the repo
      lrepo  = GitHubRepo.find(xid) # Find the copy
      if lrepo.gh_updated_at < ghrepo.updated_at # Update the database if github is newer
        count_updated += 1
        lrepo.update(name: ghrepo.name,
                     full_name: ghrepo.full_name,
                     description: ghrepo.description,
                     homepage: ghrepo.homepage,
                     ssh_url: ghrepo.ssh_url,
                     clone_url: ghrepo.clone_url,
                     html_url: ghrepo.html_url,
                     forks_count: ghrepo.forks_count,
                     stargazers_count: ghrepo.stargazers_count,
                     watchers_count: ghrepo.watchers,
                     gh_created_at: ghrepo.created_at,
                     gh_pushed_at: ghrepo.pushed_at,
                     gh_updated_at: ghrepo.updated_at,
                     gh_id: ghrepo.id,
                     fork: ghrepo.fork,
                     archived: ghrepo.archived,
                     open_issues_count: ghrepo.open_issues_count,
                     default_branch: ghrepo.default_branch,
                     issues_url: ghrepo.rels[:issues].href,
                     owner_login: ghrepo.owner.login,
                     user: user)
      end
    end
    flash[:info] = "Total: #{repos.count} Repos"
    flash[:success] = "Created/Deleted/Updated #{new_repos.count}/#{deleted_repos.count}/#{count_updated} Repos"


    redirect_to user_git_hub_repos_path
  end
end
