require 'sinatra'
require 'json'
require "github_api"

set :port, 1234

post '/payload' do
  res = JSON.parse(request.body.read)
  res.class
  action = res["action"]

  # acts only on create action
  if action == 'created'
    org_name = res["repository"]["owner"]["login"]
    repo_name = res["repository"]["name"]
    sender_name = res["sender"]["login"]
    #could also set branch to the default_branch
    branch_name = 'master'
  # Init the github api
    gh = Github.new basic_auth: 'username:password'

  # Creating an issue
    gh.issues.create(user:org_name, repo:repo_name,
      title: "Branch protections implemented",
      body:
      "Branch protections have been implemented to the #{branch_name} branch.
      The branch protections are as follows:
      > a pull request with one approver is required before merging,
      > > the code owner must review,
      > > organization and repository administrators can dismiss pull request reviews,
      > status checks must pass before merging,
      > > branches must be up to date before merging,
      > organization and repository administrators can always push
      If you have any questions, please contact @#{sender_name}.",
      assignee: sender_name).to_json

    sleep(1)
  #protect the master branch
    gh.repos.branches.protections.edit org_name, repo_name, branch_name,
      required_status_checks: {strict: true, contexts: []},
      enforce_admins: false,
      required_pull_request_reviews: {dismissal_restrictions: {users: [], teams: []},
                                      dismiss_stale_reviews: false,
                                      require_code_owner_reviews: true},
      restrictions: {users: [], teams: []}
  end
end
