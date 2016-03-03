require 'minitest/autorun'
require 'minitest/pride'
require_relative '../action'
require_relative '../task'
require 'factory_girl'
require_relative 'factories'
include FactoryGirl::Syntax::Methods

describe Action do
  before do
    Task.dataset.destroy
    @input = {:title => "Title", :description => "description", :priority => 1}
    @error = "Task not found"
    @title_error = "Title is not present"
  end

  let(:action) { Action.new }
  let(:task_test) { create :task }

  it "returns the help file" do
    help_file = File.open("help", "r") { |line| line.map { |l| l } }

    action.help.must_equal help_file
  end

  describe "with valid input" do
    it "creates a new task" do
      action.add(@input).must_equal "Task Created!"
    end
  end

  describe "when title is invalid" do
    it "returns validation error" do
      @input[:title] = ""

      action.add(@input).must_equal @title_error
    end
  end

  it "returns all the tasks order by priority" do
    pending_tasks = Task.where(:completed=>false).order(:priority).all

    action.list.must_equal pending_tasks
  end

  it "returns all completed tasks" do
    completed_tasks = Task.where(:completed=>true).all

    action.list_completed.must_equal completed_tasks
  end

  it "returns all hot tasks" do
    hot_tasks = Task.where(:priority=>1).all

    action.list_hot.must_equal hot_tasks
  end

  it "returns all sunny tasks" do
    sunny_tasks = Task.where(:priority=>2).all

    action.list_sunny.must_equal sunny_tasks
  end

  it "returns all cool tasks" do
    cool_tasks = Task.where(:priority=>3).all

    action.list_cool.must_equal cool_tasks
  end

  describe "when task is found" do
    it "returns a task" do
      task = Task[task_test.id]

      action.show(task_test.id).must_equal task
    end
  end

  describe "when task not found showing a task" do
    it "returns error" do
      action.show(111111111111111).must_equal @error
    end
  end

  describe "with found task" do
    it "updates a task" do
      @input[:priority] = 2

      action.edit(task_test.id, @input).must_equal "Task Updated!"
    end
  end

  describe "with found task" do
    it "returns validation error" do
      @input[:title] = ""

      action.edit(task_test.id, @input).must_equal @title_error
    end
  end

  describe "when task not found updating a task" do
    it "returns error" do
      action.edit(111111111111111, @input).must_equal @error
    end
  end

  describe "with found task marking as complete" do
    it "marks a task as done and returns a message" do
      action.done(task_test.id).must_equal "Another one bites the dust!"
      Task[task_test.id].completed.must_equal true
    end
  end

  describe "when task not found marking as complete" do
    it "returns error" do
      action.done(111111111111111).must_equal @error
    end
  end

  describe "with found task deleting" do
    it "deletes a task" do
      action.remove(task_test.id)

      Task[task_test.id].must_be_nil
    end
  end

end
