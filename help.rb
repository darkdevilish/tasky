require_relative 'action'

class Help
  ACTIONS = {
    :h => :help,
    :a => :add,
    :l => :list,
    :s => :show,
    :d => :done,
    :e => :edit,
    :r => :remove,
    :q => :quit
  }
  PRIORITY = {:hot => 1, :sunny => 2, :cool => 3}

  def initialize
    @action = Action.new
  end

  def welcome_msg
    print "\n\n" + "*" * 12 + "  " * 2
    print "Howdy! Welcome to your Tasky" + "  " *2
    print "*" * 12 + "\n\n"
  end

  def action_list
    puts "\nActions: #{ACTIONS.values.join(" | ")}\n\n"
  end

  def init
    action = nil
    welcome_msg
    list
    until action == :quit
      action_list
      print "\n \n >  "
      user_input = gets.chomp
      action = call_action(user_input)
    end
  end

  def call_action(input)
    error = "\n" + "*" * 12 + " " * 3 + "Invalid Command" + " " * 3 + "*" * 12 + "\n\n"
    if input.length == 1
      if ACTIONS.include?(input.to_sym)
        send(ACTIONS[input.to_sym])
      else
        puts error
      end
    else
      if ACTIONS.has_value?(input.to_sym)
        send(input)
      else
        puts error
      end
    end
  end

  def quit
    puts "\n" + "*" * 12 + "Good Bye!" + "*" * 12 + "\n\n"
    :quit
  end

  def add
    user_input = {
      :title => "",
      :description => "",
      :completed => false,
      :priority => 1
    }
    print "Please provide the task title: "
    ask = valid_title?
    user_input[:title] = ask
    print "Please provide the task description: "
    ask = gets.chomp
    user_input[:description] = ask
    print "Please provide the task priority (can be hot, sunny or cool) : "
    ask = valid_priority?
    user_input[:priority] = PRIORITY[ask]
    print "\n" + "*" * 12 + " " * 5
    print Action.new.add(user_input)
    print " " * 5 + "*" * 12 + "\n\n"
  end

  def valid_title?
    ask = gets.chomp.strip
    until ask != ""
      print "Title can't be blank: "
      ask = gets.chomp.strip
    end
    ask
  end

  def valid_priority?
    ask = gets.chomp
    until PRIORITY.include?(ask.to_sym)
      print "Not a valid priority(hot, sunny or cool): "
      ask = gets.chomp
    end
    ask.to_sym
  end

  def done
    print "\nPlease provide the id of the task you would like to mark as done:  "
    ask = gets.chomp
    print "\n" + "*" * 12 + " " * 5
    print @action.done(ask.to_i) + "  " * 5
    print "*" * 12 + "\n\n"
  end

  def help
    @action.help.each { |line| puts line }
  end

  def list
    puts "\nPending Tasks\n".center(50)
    show_task_header
    @action.list.each do |task|
      show_task(task)
    end
  end

  def show_task(task)
    print "\n" + task.id.to_s.ljust(6) + task.title.ljust(30)
    print completed?(task.completed).ljust(12)
    print PRIORITY.invert[task.priority].to_s.rjust(3) + "\n\n"
  end

  def show_task_header
    print "\n" + "ID".ljust(6) + "TITLE".ljust(30)
    print "STATUS".ljust(12) + "PRIORITY".rjust(3) + "\n"
  end

  def show
    print "\nPlease provide the id of the task that you would like to see:  "
    ask = gets.chomp
    if valid_task?(ask)
      task = get_task(ask)
      show_task_header
      show_task(task)
      puts "Task Description: "
      puts "\n#{task.description}\n\n"
    else
      puts task_not_found
    end
  end

  def completed?(status)
    if status
      "completed"
    else
      "pending"
    end
  end

  def remove
    print "\nPlease provide the id of the task that you would like to delete: "
    ask = gets.chomp
    if valid_task?(ask)
      task = get_task(ask)
      puts "\nAre you sure that you want to delete the task: "
      show_task_header
      show_task(task)
      print "\n y/n : "
      confirm = gets.chomp
      decide_destroy(confirm, ask)
    else
      puts task_not_found
    end
  end

  def decide_destroy(input, id)
    input = confirm_destroy(input)
    if input == "y"
      @action.remove(id)
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

  def confirm_destroy(input)
    ask = input
    valid = valid_confirmation?(ask)
    until valid
      print "\n y/n: "
      ask = gets.chomp
      valid = valid_confirmation?(ask)
    end
    ask
  end

  def valid_task?(id)
    task = @action.show(id)
    if task == "Task not found"
      false
    else
      true
    end
  end

  def task_not_found
    "\n#{"*"*10}   Task not found   *#{"*"*10}\n\n"
  end

  def get_task(id)
    task = @action.show(id)
  end

end

Help.new.init
