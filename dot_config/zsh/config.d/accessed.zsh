# List files which have been accessed within the last x days, defaults to 1
function accessed () {
    print -l -- *(a-${1:-1})
}
