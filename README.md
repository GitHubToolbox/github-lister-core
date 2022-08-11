<p align="center">
    <a href="https://github.com/DevelopersToolbox/">
        <img src="https://cdn.wolfsoftware.com/assets/images/github/organisations/developerstoolbox/black-and-white-circle-256.png" alt="DevelopersToolbox logo" />
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/github-lister-core/actions/workflows/pipeline.yml">
        <img src="https://img.shields.io/github/workflow/status/DevelopersToolbox/github-lister-core/pipeline/master?style=for-the-badge" alt="Github Build Status">
    </a>
    <a href="https://github.com/DevelopersToolbox/github-lister-core/releases/latest">
        <img src="https://img.shields.io/github/v/release/DevelopersToolbox/github-lister-core?color=blue&label=Latest%20Release&style=for-the-badge" alt="Release">
    </a>
    <a href="https://github.com/DevelopersToolbox/github-lister-core/releases/latest">
        <img src="https://img.shields.io/github/commits-since/DevelopersToolbox/github-lister-core/latest.svg?color=blue&style=for-the-badge" alt="Commits since release">
    </a>
    <br />
    <a href=".github/CODE_OF_CONDUCT.md">
        <img src="https://img.shields.io/badge/Code%20of%20Conduct-blue?style=for-the-badge" />
    </a>
    <a href=".github/CONTRIBUTING.md">
        <img src="https://img.shields.io/badge/Contributing-blue?style=for-the-badge" />
    </a>
    <a href=".github/SECURITY.md">
        <img src="https://img.shields.io/badge/Report%20Security%20Concern-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/github-lister-core/issues">
        <img src="https://img.shields.io/badge/Get%20Support-blue?style=for-the-badge" />
    </a>
    <br />
    <a href="https://wolfsoftware.com/">
        <img src="https://img.shields.io/badge/Created%20by%20Wolf%20Software-blue?style=for-the-badge" />
    </a>
</p>

## Overview

The gem aims to provide a simple, fast and, clean way to extract organisation and repository information from GitHub. It comes with several methods but it is intentionally limited. 

This was written to work as the lookup core for some other projects, but we felt people may be able to make use of it as a standalone library.

### External Libraries

We make use of a number of external (3<sup>rd</sup> party) gems within this project.

| Name | Source | Purpose |
| ---- | ------ | ------- |
| Octokit | [rubygems.org](https://rubygems.org/gems/octokit) | Simple wrapper for the GitHub API |
| Parallel | [rubygems.org](https://rubygems.org/gems/parallel) | Run any kind of code in parallel processes |


## Usage

```ruby
require 'github-lister-core'

# Not a real token
options = { :token => '1234567890abcdef1234567890abcdef1234567890abcdef' }

GithubListerCore.user_repos(options)
```

> You can access all of the methods using the alias GCL instead of GithubListerCore

### Methods

> Work out the parameters for each of these!

| Function | Parameters | Purpose |
| -------- | ---------- | ------- |
| all\_repos | user\_repos + user\_org\_repos |
| org\_members_repos | Details about all repositories in all organisations a user is a member of |
| org\_membership | Details about all the organisation a user is a member of (authenticated user or parameter)| 
| org\_repos | Details about all repositories within an organisation passed via :org or :org_name |
| user\_repos | Authenticated username, :user, users, :username or :usernames | Details about all of the repositories owned by the user |
| validate_user | User list | Validate users list of users, and returns a hash of all usernames and their validity status |

#### Method Returns

All of the exposed methods will return data in JSON format.

#### Exceptions

| Name | Meaning |
| ---- | ------- |
| GithubListerCore::InvalidTokenError | An invalid GitHub PAT was used |
| GithubListerCore::MissingTokenError | No GitHub PAT was supplied when expected |
| GithubListerCore::SAMLProtected | GitHub PAT not granted access to specific organisation |
| GithubListerCore::TooManyRequests | To many requests made to the GitHub API |
| GithubListerCore::NotFoundError | Requested entity not found (e.g. username or org name) |
| GithubListerCore::MissingOrganisationError | Organisation name not supplied when expected |
| GithubListerCore::InvalidOptionsHashError | The options were not passed as a hash |
| GithubListerCore::InvalidParameterError | The parameter was not supplied as a string or array as expected |
| GithubListerCore::UnknownError | General 'something bad happened' error |

### Options

| Option Name | Type | Default Value | Purpose |
| ----------- | ---- | ------------- | ------- |
| :add\_languages | Boolean | false | This will add the repository languages to the details (Requires an additional API query per repo) |
| :add\_latest\_release | Boolean | false | This will add information about the latest release to the details (Requires an additional API query per repo) |
| :add\_releases | Boolean | false | This will add information about releases to the repository (Requires an additional API query per repo) |
| :add\_topics | Boolean | false | This will add the repository topics to the details (Requires an additional API query per repo) |
| :add\_workflows | Boolean | false | This will add the repository workflow information to the details (Requires an additional API query per repo) |
| :detailed\_orgs | Boolean | false | This will return the full details about an organisation instead of the default abridged version. (Requires an additional API query per organisation) |
| :org or :org\_name | String | unset | The name of the organisation to use when performing queries. (This is only used by the org_repos method and is required for this method) |
| :org\_regex | String | unset | This is the regex pattern you want to use to filter the results for organisations by name |
| :org\_regex\_nocase | Boolean | false | Set to true to make organisation name regex matching case insensitive | 
| :regex\_nocase | Boolean | false | Set to true to make **ALL** regex matching case insensitive | 
| :repo\_regex | String | unset | This is the regex pattern you want to use to filter the results for repositories by name |
| :repo\_regex\_nocase | Boolean | false | Set to true to make repository name regex matching case insensitive | 
| :token | String | unset | The GitHub authentication token (require if no username) |
| :use\_slugs | Boolean | false | This will return only the repo name (:full\_name) or the organisation name (:login) instead of the full details |
| :user, :users, :username or :usernames | String | unset | The GitHub username or names to use when performing queries (If no username is given, the username of the current authenticates user will be used instead) |

> :user, :users, :username, :usernames, :org, :org_name can be either a single user/organisation name _OR_ a comma-separated list of user/organisation names _OR_ an array of user/organisation names. If more than one name is given, the results for all names will be merged together into one result set.

## Contributing

We are always happy for people to contribute, if you want to do so the following information should assist you in setting up a local dev environment.

Please keep in mind the purpose of this tool, it implements a very specific and narrow set of the GitHub API but this is by design, so we may not always accept pull requests if we feel they are taking the project too far beyond its designed scope.

### Setup

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

### Testing

For local testing make sure that you run `bundle exec rspec spec` and then `rake install` to install the gem locally.

For further information please refer to the [contributing](.github/CONTRIBUTING.md) documentation.

## Coming soon

There are a number of additional features that we are planning to add in the coming months. All of which will be new options that can be passed to the main methods.

| Feature | Details |
| ------- | ------- |
| Organisation members | Optionally retrieve a list of members within organisations |
| Outside collaborators | Optionally retrieve a list of outside collaborators within organisations |
| Teams | Optionally retrieve a list of teams within organisations |
| Team members | Optionally retrieve a list team members for teams within organisations |
| Team repositories | List repositories for a given team<sup>1</sup> |

> <sup>1</sup> This can be used the same way as user and organisation listing.
