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

        def user_details_from_github(client, user)
            begin
                function_wrapper(client, 'user', user)
            rescue GithubListerCore::NotFoundError
                status = { user => 'invalid' }
            else
                status = { user => 'valid' }
            end
            status
        end

        def validate_user_private(client, user_list)
            (users ||= []) << Parallel.map(user_list, :in_threads => user_list.count) { |user| user_details_from_github(client, user) }
            # rubocop:disable Style/EmptyLiteral
            users.flatten.reduce Hash.new, :merge
            # rubocop:enable Style/EmptyLiteral
        end

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
        def get_user_list_internal(client, user_list)
            authed = get_authed_username(client)

            return convert_to_array(authed) unless user_list

            case user_list
            when Array, String
                process_user_list(user_list, authed)
            else
                raise InvalidParameterError.new
            end
        end

        def get_complete_user_list_array(options)
            users = convert_to_array(get_option(options, :user))
            user = convert_to_array(get_option(options, :users))
            usernames = convert_to_array(get_option(options, :username))
            username = convert_to_array(get_option(options, :usernames))

            (user + users + username + usernames).uniq
        end

        def get_user_list_no_authed_replace(client, options)
            user_list = get_complete_user_list_array(options)

            user_list = get_user_list_internal(client, user_list)

            user_list.sort
        end

        def get_user_list(client, options)
            user_list = get_complete_user_list_array(options)

            user_list = get_user_list_internal(client, user_list)

            user_list.sort
        end
    end
end
