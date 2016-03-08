class Show

  def run
    msg = "Please provide the id of the task that you would like to see:  "
    id = Ask.question(msg)
    Task.valid_task?(Task[id], :display)
  end

end
