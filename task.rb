require "sequel"
require_relative 'db'

class Sequel::Model
  alias_method :save!, :save
end

class Task < Sequel::Model

  class ConfigPriority
    PRIORITY = { :hot => 1, :sunny => 2, :cool => 3 }

    def self.priority; PRIORITY ; end
  end

  plugin :validation_helpers

  def validate
    super
    validates_presence [:title]
  end

  def self.pending
    where(:completed=>false).order(:priority).all
  end

  def self.completed
    where(:completed=>true).all
  end

  def self.hot
    where(:priority=>1).all
  end

  def self.sunny
    where(:priority=>2).all
  end

  def self.cool
    where(:priority=>3).all
  end

  def self.updating_msg
    print "\n" + "*" * 12 + " " * 5
    print "Another one bites the dust!" + "  " * 5
    print "*" * 12 + "\n\n"
  end

  def self.complete(task)
    task.update(:completed => true)
    updating_msg
  end

  def self.valid_task?(task, name)
    if task == nil
      not_found
    else
      send(name, task)
    end
  end

  def self.task_table(task)
    print "\n" + task.id.to_s.ljust(6) + task.title.ljust(30)
    print completed?(task.completed).ljust(12)
    print Task::ConfigPriority.priority.invert[task.priority].to_s.rjust(3) + "\n\n"
  end

  def self.show(task)
    if task == nil
      not_found
    else
      task_table(task)
    end
  end

  def self.display(task)
    header
    show(task)
    puts "Task Description: "
    puts "\n#{task.description}\n\n"
  end

  def self.header
    print "\n" + "ID".ljust(6) + "TITLE".ljust(30)
    print "STATUS".ljust(12) + "PRIORITY".rjust(3) + "\n"
  end

  def self.completed?(status)
    if status
      "completed"
    else
      "pending"
    end
  end

  def self.not_found
    print "\n#{"*"*10}   Task not found   *#{"*"*10}\n\n"
  end

end
