# ===================================================================
# myalias: A simple function to print custom aliases from ~/zsh/aliases
#
# USAGE:
#   myalias        - Shows aliases from all files in the aliases folder.
#   myalias [group] - Shows aliases from a specific group file.
# ===================================================================
myalias() {
    local alias_dir="$HOME/zsh/aliases"
    local files_to_read

    if [ -z "$1" ]; then
        # No group specified, find all files in the directory.
        files_to_read=($alias_dir/*.alias(N))
    else
        # Group specified, target that one file by adding the .alias suffix.
        files_to_read="$alias_dir/$1.alias" # <-- FIX IS HERE
        if [ ! -f "$files_to_read" ]; then
            echo "Error: Alias group '$1' not found in $alias_dir" >&2
            return 1
        fi
    fi

    # Read the file(s), remove comments, format, and print as a table.
    echo "ALIAS\tCOMMAND"
    echo "-----\t-------"
    cat $files_to_read \
        | grep --invert-match --extended-regexp "^#" \
        | sed -E "s/alias ([^=]+)='(.*)'/\1\t\2/" \
        | column -t -s$'\t'
}
