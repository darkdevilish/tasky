class Help
  ACTIONS = ["help", "add", "list", "done", "edit", "remove", "quit"]

  def welcome_msg
    puts "\n\n**********    Howdy! Welcome to your Tasky    **********\n\n"
  end

  def action_list
    puts "    Actions: " + ACTIONS.join(" | ")
  end

  def init
    user_input = nil
    until user_input == "quit"
      welcome_msg
      action_list
      print "\n \n >"
      user_input = gets.chomp
    end
  end

end

Help.new.init
