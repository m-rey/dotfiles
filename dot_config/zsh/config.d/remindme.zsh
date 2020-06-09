remindme() {
	( sleep $2 && timeout ${3:-5} sm "$1" ) &
}
