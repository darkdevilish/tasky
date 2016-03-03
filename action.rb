require_relative 'task'

class Action
  def initialize
    @error = "Task not found"
  end

  def help
    File.open("help", "r") { |line| line.map { |l| l } }
  end

  def add(input)
    task = Task.new(input)

    if task.valid?
      task.save
      "Task Created!"
    else
      "Title #{task.errors[:title][0]}"
    end
  end

  def list
    Task.where(:completed=>false).order(:priority).all
  end

  def list_completed
    Task.where(:completed=>true).all
  end

  def list_hot
    Task.where(:priority=>1).all
  end

  def list_sunny
    Task.where(:priority=>2).all
  end

  def list_cool
    Task.where(:priority=>3).all
  end

  def show(id)
    if Task[id] == nil
      @error
    else
      Task[id]
    end
  end

  def edit(id, input)
    if Task[id] == nil
      @error
    else
      if input[:title].empty?
        "Title is not present"
      else
        Task[id].update(input)
        "Task Updated!"
      end
    end
  end

  def done(id)
    if Task[id] == nil
      @error
    else
      Task[id].update(:completed => true)
      "Another one bites the dust!"
    end
  end

  def remove(id)
    Task[id].destroy
  end

end
