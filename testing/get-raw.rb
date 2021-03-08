#!/usr/bin/env ruby
#
# This is a very simply testing script to allow for testing of local changes without having to install the gem locally
#

require 'json'

$LOAD_PATH.unshift('./lib')

require 'bundler/setup'
require 'github-lister-core'

config = {}

def count_results(results)
    puts JSON.parse(results).size
end

def display_results(results)
    puts JSON.pretty_generate(JSON.parse(results))
end

count_results(GithubListerCore.user_repos(config))
display_results(GithubListerCore.user_repos(config))

count_results(GithubListerCore.org_repos(config))
display_results(GithubListerCore.org_repos(config))

count_results(GithubListerCore.org_members_repos(config))
display_results(GithubListerCore.org_members_repos(config))

count_results(GithubListerCore.all_repos(config))
display_results(GithubListerCore.all_repos(config))

count_results(GithubListerCore.org_membership(config))
display_results(GithubListerCore.org_membership(config))
