#
# Define our own errors
#
class GithubListerCore
    #
    # Catch all - something bad happened but we don't know what
    #
    class UnknownError < StandardError
        def initialize
            super('Something bad happen!')
        end
    end

    #
    # User supplied an invalid token (instead of a missing token)
    #
    class InvalidTokenError < StandardError
        def initialize
            super('Invalid Token')
        end
    end

    #
    # User didn't supply a token but one was expected
    #
    class MissingTokenError < StandardError
        def initialize
            super('Missing Token - Please refer to https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token#creating-a-token')
        end
    end

    #
    # Github rate limited us!
    #
    class TooManyRequests < StandardError
        def initialize
            super('Too Many Requests')
        end
    end

    #
    # Generic 'not found' for users / orgs etc
    #
    class NotFoundError < StandardError
        def initialize
            super('Entity Not Found')
        end
    end

    #
    # Docs to go here
    #
    class MissingOrganisationError < StandardError
        def initialize
            super('org_name MUST be passed as an option')
        end
    end

    #
    # Docs to go here
    #
    class InvalidOptionsHashError < StandardError
        def initialize
            super('Options must be passed as a hash')
        end
    end

    #
    # Must be string or array!
    #
    class InvalidParameterError < StandardError
        def initialize
            super('Value must be a string or an array')
        end
    end
end
