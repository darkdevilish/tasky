class List

  OPTIONS = [ :all, :pending, :done, :hot, :sunny, :cool ]

  def call(option)
    send(option.to_sym)
  end

  def option?
    print "What you would like to list: "
    option = gets.chomp
    until OPTIONS.include?(option.to_sym)
      valid_options
      option = gets.chomp
    end
    option
  end

  def valid_options
    puts "\n" + "Valid Options".center(50) + "\n"
    puts "\nall | pending | completed | hot | sunny | cool\n"
    print "\nPlease enter a valid option: "
  end

  def all
    puts "\n" + "  All Tasks  ".center(50) + "\n"
    Task.header
    Task.dataset.all.each { |task| Task.show(task) }
  end

  def pending
    display(:pending)
  end

  def done
    display(:done)
  end

  def hot
    display(:hot)
  end

  def sunny
    display(:sunny)
  end

  def cool
    display(:cool)
  end

  def run
    option = option?
    call(option)
  end

  def display(option)
    puts "\n" + "  #{option.to_s.capitalize} Tasks  ".center(50) + "\n"
    Task.header
    Task.method(option).call.each { |task| Task.show(task) }
  end

end
