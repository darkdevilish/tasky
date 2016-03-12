class Quit

  def msg
    puts "\n" + "*" * 12 + "Good Bye!" + "*" * 12 + "\n\n"
  end

  def run
    msg
    :quit
  end

end
