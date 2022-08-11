#
# Handle anything specific to the user
#
class GithubListerCore
    class << self
        #
        # Everything below here is private
        #

        private

        def decode_sawyer_array(array)
            results = []

            array.each do |element|
                results.append(decode_sawyer_resource(element))
            end
            results
        end

        def decode_sawyer_resource(item)
            case item
            when Sawyer::Resource
                item.to_h
            when Array
                decode_sawyer_array(item)
            else
                item
            end
        end

        def clean_from_parallel(item, sorted = nil)
            return {} if item.nil?

            item = item.flatten.map(&:to_h).uniq
            item = item.sort_by { |repo| repo[sorted].downcase } if sorted
            item
        end

        def convert_to_array(item)
            case item
            when Sawyer::Resource
                [].append(item)
            when Array
                item
            when String
                item.split(',').map(&:strip).uniq.sort
            else
                []
            end
        end

        def validate_options(options)
            raise InvalidOptionsHashError.new unless options.is_a?(Hash)
        end

        def look_for_option_from_array(options, names)
            names.each { |name| return options[name] if options.key?(name) }
            nil
        end

        def get_option(options, names)
            return nil unless options
            return nil unless options.is_a?(Hash)

            case names
            when Array
                value = look_for_option_from_array(options, names)
            when String, Symbol
                value = options[names] if options.key?(names)
            end
            value || nil
        end

        def flag_set?(options, option)
            value = get_option(options, option)

            return false unless value

            return false unless value == true

            true
        end

        def get_flag(options, option)
            flag_set?(options, option)
        end

        def add_additional_info(client, options, repos)
            return repos if flag_set?(options, :use_slugs)

            repos = add_topics_private(client, repos) if flag_set?(options, :add_topics)
            repos = add_latest_release_private(client, repos) if flag_set?(options, :add_latest_release)
            repos = add_releases_private(client, repos) if flag_set?(options, :add_releases)
            repos = add_languages_private(client, repos) if flag_set?(options, :add_languages)
            repos = add_workflows_private(client, repos) if flag_set?(options, :add_workflows)
            repos
        end
    end
end
