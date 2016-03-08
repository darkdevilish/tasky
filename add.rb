class Add

  def run
    task = Task.new
    task[:title] = Ask.task_title
    task[:description] = Ask.question("Please provide the task description: ")
    ask_task_priority = Ask.question("Please provide the priority(can be hot, sunny or cool): ")
    valid_priority = valid_priority?(ask_task_priority)
    task[:priority] = Task::ConfigPriority.priority[valid_priority]
    task[:completed] = false
    create_task(task)
  end

  def create_task(task)
    if task.valid?
      task.save
      puts "Task Created!"
    else
      creation_msg(task)
    end
  end

  def creation_msg(task)
    print "\n" + "*" * 12 + " " * 5
    print "Title #{task.errors[:title][0]}"
    print " " * 5 + "*" * 12 + "\n\n"
  end

  def valid_priority?
    priority = gets.chomp
    until Task::ConfigPriority.include?(priority.to_sym)
      print "Not a valid priority(hot, sunny or cool): "
      priority = gets.chomp
    end
    priority.to_sym
  end

  def valid_title?(title)
    print "Title can't be blank: " if title.empty?
  end
end
