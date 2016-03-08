class Ask

  def self.question(msg)
    print "\n#{msg}"
    ask = gets.chomp
  end

  def self.task_title
    print "Please provide the task title: "
    title = gets.chomp.strip
    until title != ""
      valid_title?(title)
      title = gets.chomp.strip
    end
    title
  end

end
