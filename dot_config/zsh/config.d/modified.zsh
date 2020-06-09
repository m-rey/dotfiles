# List files which have been modified within the last x days, defaults to 1
function modified () {
    print -l -- *(m-${1:-1})
}
