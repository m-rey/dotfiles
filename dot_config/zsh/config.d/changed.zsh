# List files which have been changed within the last x days, defaults to 1
function changed () {
    print -l -- *(c-${1:-1})
}
