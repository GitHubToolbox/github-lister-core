#
# Octokit has a missing PREVIEW type
#
class GithubListerCore
    #
    # Missing from Octokit
    #
    PREVIEW_TYPES = {
        :visibility => 'application/vnd.github.nebula-preview+json'
    }.freeze
end
