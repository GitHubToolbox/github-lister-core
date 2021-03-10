#
# This class
#
class GithubListerCore
    class << self
        #
        # Everything below here is private
        #

        private

        def latest_release_private(client, repo)
            begin
                release = function_wrapper(client, 'latest_release', repo)
            # rubocop:disable Lint/SuppressedException
            rescue NotFoundError => _exception
            end
            # rubocop:enable Lint/SuppressedException
            decode_sawyer_resource(release) || {}
        end

        #
        # Add topics to each repo
        #
        # This method smells of :reek:FeatureEnvy
        def add_latest_release_private(client, repos)
            (repo_list ||= []) << Parallel.each(repos, :in_threads => repos.count) { |repo| repo[:latest_release] = latest_release_private(client, repo[:full_name]) }
            repo_list.flatten
        end

        #
        # All releases
        #
        def releases_private(client, repo)
            begin
                releases = function_wrapper(client, 'releases', repo)
            # rubocop:disable Lint/SuppressedException
            rescue NotFoundError => _exception
            end
            # rubocop:enable Lint/SuppressedException
            decode_sawyer_resource(releases) || []
        end

        #
        # Add topics to each repo
        #
        # This method smells of :reek:FeatureEnvy
        def add_releases_private(client, repos)
            (repo_list ||= []) << Parallel.each(repos, :in_threads => repos.count) { |repo| repo[:releases] = releases_private(client, repo[:full_name]) }
            repo_list.flatten
        end
    end
end
