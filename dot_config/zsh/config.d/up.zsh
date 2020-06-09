function up () {
    local tmp_path=''
    for i in $(seq 1 ${1:-1})
    do
        tmp_path+='../'
    done
    cd "$tmp_path"
}
