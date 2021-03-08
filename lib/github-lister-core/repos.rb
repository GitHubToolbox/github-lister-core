#
# Pull information specific to respositories
#
class GithubListerCore
    class << self
        #
        # Everything below here is private
        #

        private

        ########################################################################
        # User Owned Repositories                                              #
        ########################################################################

        def user_repos_from_github(client, user)
            function_wrapper(client, 'repositories', user, { :type => 'owner', :accept => PREVIEW_TYPES[:visibility] })
        end

        def user_repos_in_parallel(client, users)
            (repos ||= []) << Parallel.map(users, :in_threads => users.count) { |user| user_repos_from_github(client, user) }
            clean_from_parallel(repos, :full_name)
        end

        def user_repos_private(client, options, users)
            repos = user_repos_in_parallel(client, users)
            add_additional_info(client, options, repos)
        end

        def user_repo_slugs_private(client, users)
            repos = user_repos_in_parallel(client, users)
            repos.map { |hash| hash[:full_name] }.compact
        end

        ########################################################################
        # Organisation Owned Repositories                                      #
        ########################################################################

        def org_repos_from_github(client, org)
            function_wrapper(client, 'organization_repositories', org)
        end

        def org_repos_in_parallel(client, orgs)
            (repos ||= []) << Parallel.map(orgs, :in_threads => orgs.count) { |org| org_repos_from_github(client, org) }
            clean_from_parallel(repos, :full_name)
        end

        def org_repos_private(client, options, orgs)
            repos = org_repos_in_parallel(client, orgs)
            add_additional_info(client, options, repos)
        end

        def org_repo_slugs_private(client, orgs)
            repos = org_repos_in_parallel(client, orgs)
            repos.map { |hash| hash[:full_name] }.compact
        end

        ########################################################################
        # Organisation Owned Repositories for ALL Organsations users are a     #
        # member of                                                            #
        ########################################################################

        def org_members_repos_private(client, options, users)
            orgs = org_membership_slugs_private(client, users)
            repos = org_repos_in_parallel(client, orgs)
            add_additional_info(client, options, repos)
        end

        def org_members_repo_slugs_private(client, users)
            orgs = org_membership_slugs_private(client, users)
            repos = org_repos_in_parallel(client, orgs)
            repos.map { |hash| hash[:full_name] }.compact
        end

        #
        # Generate a slub list of repos for all organisations that a user is a member of
        #
        def all_repos_private(client, options, users)
            repos = user_repos_private(client, options, users) + org_members_repos_private(client, options, users)
            repos.flatten.sort_by { |repo| repo[:full_name].downcase }
        end

        #
        # Get a list of ALL repos that a user has access to (This is both personal and via organisations)
        # If the user is authenticated and a member of the org it will list private + public
        #
        def all_repo_slugs_private(client, users)
            repos = user_repo_slugs_private(client, users) + org_members_repo_slugs_private(client, users)
            repos.flatten.sort
        end
    end
end
