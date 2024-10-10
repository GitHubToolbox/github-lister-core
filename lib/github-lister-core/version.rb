class GithubListerCore
    # Current major release.
    MAJOR = 0

    # Current minor release.
    MINOR = 1

    # Current patch level.
    PATCH = 8

    # Full release version.
    VERSION = [MAJOR, MINOR, PATCH].join('.').freeze
end
