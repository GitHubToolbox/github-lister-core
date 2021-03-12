#
# Handle anything specific to the user
#
# This class smells of :reek:InstanceVariableAssumption
class GithubListerCore
    class << self
        #
        # Everything below here is private
        #

        private

        def authed_user_in_array(users, authed)
            users.select { |user| user.downcase == authed.login.downcase } != []
        end

        def process_user_list(user_list, authed)
            user_list = convert_to_array(user_list)

            return user_list unless authed

            if authed_user_in_array(user_list, authed)
                user_list.delete_if { |user| user.downcase == authed.login.downcase }
                user_list.append(authed)
            end
            user_list
        end

        def get_authed_username(client)
            begin
                client.user if client.user_authenticated?
            rescue Octokit::Unauthorized => _exception
                raise InvalidTokenError.new
            end
        end

        #
        # Users can be a string (comma separated) or an array nothing else
        #
        def get_user_list(client, options)
            user_list = get_option(options, [:user, :username])
            authed = get_authed_username(client)

            return convert_to_array(authed) unless user_list

            case user_list
            when Array, String
                process_user_list(user_list, authed)
            else
                raise InvalidParameterError.new
            end
        end
    end
end
