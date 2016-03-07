require "sequel"

DB = Sequel.sqlite("tasks.db")

unless DB.table_exists? :tasks
  DB.create_table(:tasks) do
    primary_key :id
    String :title
    String :description
    Boolean :completed
    Integer :priority
  end
end

class Sequel::Model
  alias_method :save!, :save
end

class Task < Sequel::Model
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

end
