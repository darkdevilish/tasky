require "sequel"

class DbConnection
  attr_writer :db_name
  DB = Sequel.sqlite(@db_name)

  def initialize(db)
    @db_name = db
  end

  def connect
    unless DB.table_exists? :tasks
      DB.create_table(:tasks) do
        primary_key :id
        String :title
        String :description
        Boolean :completed
        Integer :priority
      end
    end
  end

end
DbConnection.new("tasks_test.db").connect

class Sequel::Model
  alias_method :save!, :save
end

class Task < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence [:title]
  end

end
