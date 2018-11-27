# webhook-server
<hr>

### prerequisites
Rails 5.2.1<br>
ruby 2.3.1p112<br>
sinatra gem<br>
github_api gem<br>

## quick start instructions for mac

open a terminal window

clone the repository to your local machine `git clone https://github.com/codeavenger07/webhook-server.git`

navigate to the repository that was just created `cd webhook-server`

### configuring the ngrok

start ngrok `./ngrok http 1234` where '1234' is the port number set in server.rb

copy the http forwarding address

### installing required gems

open a new terminal window

navigate to the repository root

install sinatra `gem install sinatra`

install github_api `gem install github_api`

### configuring the rails app

open server.rb in a text editor

edit `gh = Github.new basic_auth: 'username:password'` with your GitHub username and password

### starting the rails app

open a new terminal window

navigate to the repository root

start the rails app `ruby server.rb`

verify the service is listening on port 1234 by checking the feedback in the terminal window

### organization setup

create a new GitHub organization by navigating to your user settings and selecting Organizations from the left hand menu then clicking New Organization

fill out the organization name, the billing email address, and the account type and then select Create Organization

add users to your organization (you are added by default)

fill out appropriate details about the organization or skip the step

### configuring the webhook

click on the Settings tab of the organization, then click on Webhooks from the left hand menu

click Add Webhook to add a webhook

paste the http forwarding address into the Payload URL followed by '/payload' (endpoint is defined in server.rb

change the Content type to application/json

select the individual event of Repositories to trigger the webhook

click Add webhook

verify the ping to the local web service was successful by ensuring a green check mark is with the newly created webhook

### creating an organization repository

navigate to the organization

click Create a new repository

name your repository

initialize the repository with a README

### outcome

the master branch will be protected

an issue will be created tagging the user and assigned to the user

## reference
https://dashboard.ngrok.com/<br>
https://www.rubydoc.info/github/piotrmurach/github/master/Github/Client/Repos/Branches/Protections<br>
https://developer.github.com/v3/<br>
https://github.com/piotrmurach/github
