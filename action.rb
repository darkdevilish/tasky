require_relative 'task'

class Action
  def help
    help_file = []
    File.open("help", "r") { |line| line.each_line { |l| help_file << l } }
    help_file
  end

  def add(input)
    if !Task.create(input).nil?
      "Task created!"
    end
  end

  def list
    Task.dataset.order(:priority).all
  end

  def edit(id, input)
    Task[id].update(input)
  end

  def done(id)
    Task[id].update(:completed => true)
  end

  def remove(id)
    Task[id].destroy
  end

  def quit
    :quit
  end
end
