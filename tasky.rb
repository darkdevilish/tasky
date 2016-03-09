require_relative 'action'
require_relative 'list'

def welcome_msg
  print "\n\n" + "*" * 12 + "  " * 2
  print "Howdy! Welcome to your Tasky" + "  " *2
  print "*" * 12 + "\n\n"
end

def action_list
  puts "\nActions: #{Action::Config.actions.values.join(" | ")}\n\n"
end

action = nil
welcome_msg
List.new.pending
action_object = Action.new

until action == :quit
  action_list
  print "\n \n >  "
  user_input = gets.chomp
  action_object.input = user_input
  action = action_object.run
end
