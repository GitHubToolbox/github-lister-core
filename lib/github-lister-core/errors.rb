#
# Define our own errors
#
class GithubListerCore
    #
    # Catch all - something bad happened but we don't know what
    #
    class UnknownError < StandardError
        def initialize(msg = 'Something bad happen!')
            super
        end
    end

    #
    # User supplied an invalid token (instead of a missing token)
    #
    class InvalidTokenError < StandardError
        def initialize(msg = 'Invalid Token')
            super
        end
    end

    #
    # User didn't supply a token but one was expected
    #
    class MissingTokenError < StandardError
        def initialize(msg = 'Missing Token - Please refer to https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token#creating-a-token')
            super
        end
    end

    #
    # Handle enterprise level tokens
    #
    class SAMLProtected < StandardError
        def initialize(msg = 'Resource protected by organization SAML enforcement. You must grant your Personal Access token access to this organization.')
            super
        end
    end

    #
    # Github rate limited us!
    #
    class TooManyRequests < StandardError
        def initialize(msg = 'Too Many Requests')
            super
        end
    end

    #
    # Generic 'not found' for users / orgs etc
    #
    class NotFoundError < StandardError
        def initialize(msg = 'Entity Not Found')
            super
        end
    end

    #
    # Docs to go here
    #
    class MissingOrganisationError < StandardError
        def initialize(msg = 'org_name MUST be passed as an option')
            super
        end
    end

    #
    # Docs to go here
    #
    class InvalidOptionsHashError < StandardError
        def initialize(msg = 'Options must be passed as a hash')
            super
        end
    end

    #
    # Must be string or array!
    #
    class InvalidParameterError < StandardError
        def initialize(msg = 'Value must be a string or an array')
            super
        end
    end
end
