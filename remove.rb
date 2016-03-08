class Remove

  def run
    msg = "Please provide the id of the task that you would like to delete: "
    id = Ask.question(msg)
    confirm = confirm(Task[id])
    destroy?(confirm, Task[id])
  end


  def confirm(task)
    puts "\nAre you sure that you want to delete the task: "
    Task.header
    Task.show(task)
    print "\n y/n : "
    confirm = gets.chomp
  end

  def destroy?(input, task)
    input = validate(input)
    if input == "y"
      task.destroy
      print "\n" + "*" * 12 + "  " * 5
      print "Task Destroyed!" + "  " * 5 + "*" * 12 + "\n\n"
    end
  end

  def valid_confirmation?(input)
    if input == "y" || input == "n"
      true
    else
      false
    end
  end

  def validate(input)
    valid = valid_confirmation?(input)
    until valid
      print "\n y/n: "
      ask = gets.chomp
      valid = valid_confirmation?(ask)
    end
    valid
  end

end
