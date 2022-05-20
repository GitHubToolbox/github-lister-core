#
# This class store the main processing wrapper which talks to the API and handles all the exceptions
#
# This class smells of :reek:InstanceVariableAssumption
class GithubListerCore
    class << self
        #
        # Everything below here is private
        #

        private

        # rubocop:disable Metrics/MethodLength
        def function_wrapper(client, function, *param)
            begin
                results = client.send(function, *param)
            rescue Octokit::Unauthorized
                raise InvalidTokenError.new if client.user_authenticated?

                raise MissingTokenError.new
            rescue Octokit::SAMLProtected
                raise SAMLProtected.new
            rescue Octokit::NotFound
                raise NotFoundError.new
            rescue Octokit::TooManyRequests
                raise TooManyRequests.new
            rescue StandardError => exception
                raise UnknownError.new(exception.to_s)
            end
            results || []
        end
        # rubocop:enable Metrics/MethodLength
    end
end
