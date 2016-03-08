class Done

  def run
    msg = "Please provide the id of the task you would like to mark as done:  "
    id = Ask.question(msg)
    Task.valid_task?(Task[id], :complete)
  end

end
