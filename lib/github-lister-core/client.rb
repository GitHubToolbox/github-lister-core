#
# This code handles the creation of the github client with or without an auth token
#
# This class smells of :reek:UtilityFunction
class GithubListerCore
    class << self
        #
        # Everything from here is private
        #

        private

        #
        # Initialise the client and set auto_paginate to true
        #
        def init_client(options = {})
            token = get_option(options, :token)
            client = if token
                         Octokit::Client.new(:access_token => token)
                     else
                         Octokit::Client.new
                     end
            client.auto_paginate = true
            client
        end
    end
end
