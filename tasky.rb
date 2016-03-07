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
