class List

  OPTIONS = [ :all, :pending, :completed, :hot, :sunny, :cool ]

  def call(option)
    send(OPTIONS[option.to_sym])
  end

  def option?
    option = gets.chomp
    until OPTIONS.include?(option.to_sym)
      print "all | pending | completed | hot | sunny | cool"
      option = gets.chomp
    end
    option
  end

  def all
    puts "\nAll Tasks\n".center(50)
    Task.header
    Task.dataset.all.each { |task| Task.show(task) }
  end

  def pending
    lists(:pending)
  end

  def completed
    lists(:completed)
  end

  def hot
    lists(:hot)
  end

  def sunny
    lists(:sunny)
  end

  def cool
    lists(:cool)
  end

  def run
    option = option?
    call(option)
  end

  def lists(option)
    puts "\n#{option.to_s.capitalize} Tasks\n".center(50)
    Task.header
    Task.method(option).call.each { |task| Task.show(task) }
  end

end
