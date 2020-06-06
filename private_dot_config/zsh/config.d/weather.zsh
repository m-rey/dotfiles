weather() {
curl --silent "http://wttr.in/{$*}" | head --lines=-2
}
