#
# Add workflows to each repository
#
class GithubListerCore
    class << self
        #
        # Everything below here is private
        #

        private

        #
        # Extra the  slug from the payload and return it
        #
        def workflows_private(client, repo)
            workflows = function_wrapper(client, 'list_workflows', repo)
            decode_sawyer_resource(workflows) || {}
        end

        #
        # Add topics to each repo
        #
        # This method smells of :reek:FeatureEnvy
        def add_workflows_private(client, repos)
            (repo_list ||= []) << Parallel.each(repos, :in_threads => repos.count) { |repo| repo[:workflows] = workflows_private(client, repo[:full_name]) }
            repo_list.flatten
        end
    end
end
