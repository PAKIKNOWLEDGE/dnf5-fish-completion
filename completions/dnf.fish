# fish completion for dnf / dnf5
# delegates to dnf5's built-in --complete mechanism
# https://github.com/user/dnf5-fish-completion

function __fish_dnf5_complete -d "Get completions from dnf5"
    set -l tokens (commandline -op)
    set -l current (commandline -t)

    # Build the full words array like bash does for dnf5 --complete
    # commandline -op returns completed tokens (before cursor)
    # commandline -t returns the token under cursor (may be partial or empty)
    if string length -q -- $current
        # Completing a partial token (e.g. "dnf co" → current="co")
        set tokens $tokens $current
        set -l cword (math (count $tokens) - 1)
        dnf5 "--complete=$cword,add_description=0" $tokens 2>/dev/null
    else
        # Cursor is at an empty position after a space
        set -l cword (count $tokens)
        dnf5 "--complete=$cword,add_description=0" $tokens "" 2>/dev/null
    end
end

# Register for both dnf and dnf5
complete -c dnf  -f -a '(__fish_dnf5_complete)'
complete -c dnf5 -f -a '(__fish_dnf5_complete)'
