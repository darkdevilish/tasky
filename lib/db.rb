config_dir = File.expand_path('~/.tasky')
unless Dir[config_dir].length > 0
  Dir::mkdir(config_dir)
end

DB = Sequel.sqlite("#{config_dir}/tasks.db")

unless DB.table_exists? :tasks
  DB.create_table(:tasks) do
    primary_key :id
    String :title
    String :description
    Boolean :completed
    Integer :priority
  end
end
