require 'minitest/autorun'
require 'minitest/pride'
require_relative 'action'
require_relative 'task'
require 'factory_girl'
include FactoryGirl::Syntax::Methods

FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task title #{n}" }
    description "Description"
    completed false
    priority 1
  end
end

describe Action do
  before do
    Task.dataset.destroy
  end

  let(:task_test) { create :task }

  it "validates help action" do
    help_file = []
    File.open("help", "r") { |line| line.each_line { |l| help_file << l } }

    Action.new.help.must_equal help_file
  end

  it "validates new action" do
    input = {:title => "Title", :description => "description", :priority => 1}

    Action.new.add(input).must_equal "Task created!"
  end

  it "validates list action" do
    tasks = Task.dataset.order(:priority).all

    Action.new.list.must_equal tasks
  end

  it "validates edit action" do
    input = {:title => "Title", :description => "description e", :priority => 2}
    Action.new.edit(task_test.id, input)

    Task[task_test.id].priority.must_equal 2
  end

  it "validates done action" do
    Action.new.done(task_test.id)

    Task[task_test.id].completed.must_equal true
  end

  it "validates remove action" do
    Action.new.remove(task_test.id)

    Task[task_test.id].must_be_nil
  end

  it "validates quit" do
    Action.new.quit.must_equal :quit
  end
end
