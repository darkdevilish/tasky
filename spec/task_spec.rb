require 'minitest/autorun'
require 'minitest/pride'
require_relative '../task'

describe Task do

  it "returns all the tasks order by priority" do
    pending_tasks = Task.where(:completed=>false).order(:priority).all

    Task.pending.must_equal pending_tasks
  end

  it "returns all completed tasks" do
    completed_tasks = Task.where(:completed=>true).all

    Task.completed.must_equal completed_tasks
  end

  it "returns all hot tasks" do
    hot_tasks = Task.where(:priority=>1).all

    Task.hot.must_equal hot_tasks
  end

  it "returns all sunny tasks" do
    sunny_tasks = Task.where(:priority=>2).all

    Task.sunny.must_equal sunny_tasks
  end

  it "returns all cool tasks" do
    cool_tasks = Task.where(:priority=>3).all

    Task.cool.must_equal cool_tasks
  end

end
