<h1 align="center">
	<a href="https://github.com/WolfSoftware">
		<img src="https://raw.githubusercontent.com/WolfSoftware/branding/master/images/general/banners/64/black-and-white.png" alt="Wolf Software Logo" />
	</a>
	<br>
	Github Lister Core Library
</h1>

<p align="center">
	<a href="https://travis-ci.com/DevelopersToolbox/github-lister-core">
		<img src="https://img.shields.io/travis/com/DevelopersToolbox/github-lister-core/master?style=for-the-badge&logo=travis" alt="Build Status">
	</a>
	<a href="https://github.com/DevelopersToolbox/github-lister-core/releases/latest">
		<img src="https://img.shields.io/github/v/release/DevelopersToolbox/github-lister-core?color=blue&style=for-the-badge&logo=github&logoColor=white&label=Latest%20Release" alt="Release">
	</a>
	<a href="https://github.com/DevelopersToolbox/github-lister-core/releases/latest">
		<img src="https://img.shields.io/github/commits-since/DevelopersToolbox/github-lister-core/latest.svg?color=blue&style=for-the-badge&logo=github&logoColor=white" alt="Commits since release">
	</a>
	<a href="LICENSE.md">
		<img src="https://img.shields.io/badge/license-MIT-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" alt="Software License">
	</a>
	<br>
	<a href=".github/CODE_OF_CONDUCT.md">
		<img src="https://img.shields.io/badge/Code%20of%20Conduct-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
	</a>
	<a href=".github/CONTRIBUTING.md">
		<img src="https://img.shields.io/badge/Contributing-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
	</a>
	<a href=".github/SECURITY.md">
		<img src="https://img.shields.io/badge/Report%20Security%20Concern-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
	</a>
	<a href=".github/SUPPORT.md">
		<img src="https://img.shields.io/badge/Get%20Support-blue?style=for-the-badge&logo=read-the-docs&logoColor=white" />
	</a>
</p>

## Overview

The gem aims to provide a simple, fast and, clean way to extract repository information from GitHub. It comes with several methods but it is intentionally limited to repository based information. 

If you are looking for a GitHub API wrapper we suggest looking at the [Octokit](https://rubygems.org/gems/octokit) gem, which is the tool we have used in this project.

This was written to work as the lookup core for some other projects, but we felt people may be able to make use of it as a standalone library.

To make the lookups as fast as possible we make extensive use of the [Parallel](https://rubygems.org/gems/parallel) gem to run as many API queries as possible in parallel.

## Usage

```ruby
require 'github-lister-core'

# Not a real token
options = { :token => '1234567890abcdef1234567890abcdef1234567890abcdef' }

GithubListerCore.user_repos(options)
```

> You can access all of the methods using the alias GCL instead of GithubListerCore

### Methods

| Function | Purpose |
| -------- | ------- |
| user\_repos | Details about all of the repositories owned by the user |
| org\_repos | Details about all repositories within an organisation |
| org\_members_repos | Details about all repositories in all organisations a user is a member of |
| all\_repos | user\_repos + user\_org\_repos |
| org\_membership | Details about all the organisation a user is a member of | 

#### Method Returns

All of the exposed methods will return data in JSON format.

### Options

| Option Name | Purpose |
| ----------- | ------- |
| :token | The GitHub authentication token (require if no username) |
| :user or :username | The GitHub username to use when performing queries (If no username is given, the username of the current authenticates user will be used instead) |
| :org or :org_name | The name of the organisation to use when performing queries. (This is only used by the org_repos method and is required for this method) |
| :use_slugs | This will return only the repo name (:full_name) or the organisation name (:login) instead of the full details |
| :add_topics | This will add the repository topics to the details (Requires an additional look query per repo) |
| :add_latest_release | This will add information about the latest release to the details (Requires an additional look query per repo) |
| :add_releases | This will add information about releases to the repository (Requires an additional look query per repo) |
| :add_languages | This will add the repository languages to the details (Requires an additional look query per repo) |

> :user, :username, :org, :org_name can be either a single user/organisation name _OR_ a comma-separated list of user/organisation names _OR_ an array of user/organisation names. If more than one name is given, the results for all names will be merged together into one result set.

## Contributing

We are always happy for people to contribute, if you want to do so the following information should assist you in setting up a local dev environment.

Please keep in mind the purpose of this tool, it implements a very specific and narrow set of the GitHub API but this is by design, so we may not always accept pull requests if we feel they are taking the project too far beyond its designed scope.

### Setup

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

### Testing

For local testing make sure that you run `bundle exec rspec spec` and then `rake install` to install the gem locally.

For further information please refer to the [contributing](.github/CONTRIBUTING.md) documentation.

## Contributors

<p>
	<a href="https://github.com/TGWolf">
		<img src="https://img.shields.io/badge/Wolf-black?style=for-the-badge" />
	</a>
</p>

## Show Support

<p>
	<a href="https://ko-fi.com/wolfsoftware">
		<img src="https://img.shields.io/badge/Ko%20Fi-blue?style=for-the-badge&logo=ko-fi&logoColor=white" />
	</a>
</p>
