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

end
