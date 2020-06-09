function lie {
    if [[ "$1" == "not" ]]
    then
        unset GIT_AUTHOR_DATE
        unset GIT_COMMITTER_DATE
        return 0
    fi
    export GIT_AUTHOR_DATE="$1"
    export GIT_COMMITTER_DATE="$1"
}
