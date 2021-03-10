#
# Add topics to each repository
#
class GithubListerCore
    class << self
        #
        # Everything below here is private
        #

        private

        #
        # Extra the topics slug from the payload and return it
        #
        def languages_private(client, repo)
            languages = function_wrapper(client, 'languages', repo)
            decode_sawyer_resource(languages)
        end

        #
        # Add topics to each repo
        #
        # This method smells of :reek:FeatureEnvy
        def add_languages_private(client, repos)
            (repo_list ||= []) << Parallel.each(repos, :in_threads => repos.count) { |repo| repo[:languages] = languages_private(client, repo[:full_name]) }
            repo_list.flatten
        end
    end
end
