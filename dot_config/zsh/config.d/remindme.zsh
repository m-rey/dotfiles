remindme() {
  # usage: `remindme $message $timetowait $messageduration
  # duration of message is 5s by default
  nohup sh -c "sleep $2 && timeout ${3:-5} sm $1" > /dev/null 2>&1 &
}
