#
# This class handles the filter of arrays of hashes based on given regex.
#
# This class smells of :reek:InstanceVariableAssumption
class GithubListerCore
    class << self
        #
        # Everything below here is private
        #

        private

        # This method smells of :reek:ControlParameter, :reek:DuplicateMethodCall
        def handle_regex(list, key, regex, nocase)
            if (nocase)
                list.select { |item| item[key].to_s.match(/#{regex}/i) }
            else
                list.select { |item| item[key].to_s.match(/#{regex}/) }
            end
        end

        def handle_repo_regex(list, options)
            nocase = get_flag(options, :repo_regex_nocase) | get_flag(options, :regex_nocase)

            handle_regex(list, :name, get_option(options, :repo_regex), nocase)
        end

        def handle_org_regex(list, options)
            nocase = get_flag(options, :org_regex_nocase) | get_flag(options, :regex_nocase)

            handle_regex(list, :login, get_option(options, :org_regex), nocase)
        end
    end
end
