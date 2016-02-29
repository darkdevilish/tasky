require 'minitest/autorun'
require 'minitest/pride'
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

describe Task do

  before do
    Task.dataset.destroy
  end

  let(:task1) { create :task }
  let(:task_test) { build :task }

  it 'validates input errors' do
    Task.new.valid?.must_equal false
    task_test.valid?.must_equal true
  end

  it 'creates a new task' do
    task_test.save.wont_be_nil
  end

  it 'list all tasks' do
    3.times do
      create :task
    end

    Task.count.must_equal 3
  end

  it 'reads a task' do
    Task[task1.id].title.must_equal task1.title
  end

  it 'marks task as completed' do
    Task[task1.id].update(:completed=>true)

    Task[task1.id].completed.must_equal true
  end

  it 'deletes a task' do
    Task[task1.id].destroy

    Task[task1.id].must_be_nil
  end

end
