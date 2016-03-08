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
    puts "\nPending Tasks\n".center(50)
    Task.header
    Task.pending.each { |task| Task.show(task) }
  end

  def completed
    puts "\nCompleted Tasks\n".center(50)
    Task.header
    Task.completed.each { |task| Task.show(task) }
  end

  def hot
    puts "\nHot Tasks\n".center(50)
    Task.header
    Task.hot.each { |task| Task.show(task) }
  end

  def sunny
    puts "\nSunny Tasks\n".center(50)
    Task.header
    Task.sunny.each { |task| Task.show(task) }
  end

  def cool
    puts "\nCool Tasks\n".center(50)
    Task.header
    Task.cool.each { |task| Task.show(task) }
  end

  def run
    option = option?
    call(option)
  end

end
