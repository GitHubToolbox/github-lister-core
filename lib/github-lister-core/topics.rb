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
        def topics_private(client, repo)
            topics = function_wrapper(client, 'topics', repo)
            topics[:names]
        end

        #
        # Add topics to each repo
        #
        # This method smells of :reek:FeatureEnvy
        def add_topics_private(client, repos)
            (repo_list ||= []) << Parallel.each(repos, :in_threads => repos.count) { |repo| repo[:topics] = topics_private(client, repo[:full_name]) }
            repo_list.flatten
        end
    end
end
