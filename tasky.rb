require_relative 'action'
require_relative 'task'
require_relative 'ask'
require_relative 'help'
require_relative 'list'
require_relative 'add'
require_relative 'show'
require_relative 'done'
require_relative 'remove'
require_relative 'quit'

def welcome_msg
  print "\n\n" + "*" * 12 + "  " * 2
  print "Howdy! Welcome to your Tasky" + "  " *2
  print "*" * 12 + "\n\n"
end

def action_list
  puts "\nActions: #{Action::Config.actions.values.join(" | ")}\n\n"
end

def show_progress
  total_tasks = Task.dataset.all.count
  total_tasks_done = Task.done.count
  total_todo = Task.pending.count
  percentage = total_tasks_done * 100 / (total_tasks.nonzero? || 1)
  puts "\n" + "To Do #{total_todo} | #{percentage}% done".center(50)
end

action = nil
welcome_msg
List.new.pending
action_object = Action.new

until action == :quit
  action_list
  show_progress
  print "\n \n >  "
  user_input = gets.chomp
  action_object.input = user_input
  action = action_object.run
end
