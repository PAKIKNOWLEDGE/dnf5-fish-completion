# fish completion for dnf / dnf5
# delegates to dnf5's built-in --complete mechanism
# https://github.com/user/dnf5-fish-completion

function __fish_dnf5_complete -d "Get completions from dnf5"
    # Get the current commandline tokens
    set -l tokens (commandline -op)
    set -l cmdline (commandline)

    # Detect if we're completing a new empty position (cursor after trailing space)
    # or completing the current partial word
    if string match -q -r '\s$' -- $cmdline
        # Trailing space → completing an empty position after the last token
        # dnf5 expects words array to include the empty position
        set -l cword (count $tokens)
        dnf5 "--complete=$cword,add_description=0" $tokens "" 2>/dev/null
    else
        # No trailing space → completing the current token itself
        set -l cword (math (count $tokens) - 1)
        if test $cword -ge 0
            dnf5 "--complete=$cword,add_description=0" $tokens 2>/dev/null
        end
    end
end

# Register for both dnf and dnf5
complete -c dnf  -f -a '(__fish_dnf5_complete)'
complete -c dnf5 -f -a '(__fish_dnf5_complete)'
