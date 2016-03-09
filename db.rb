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
