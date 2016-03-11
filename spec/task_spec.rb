require 'minitest/autorun'
require 'minitest/pride'
require_relative '../task'
require 'factory_girl'
require_relative 'factories'
include FactoryGirl::Syntax::Methods

describe Task do

  before do
    Task.dataset.destroy
  end

  let(:task1) { create :task }
  let(:task2) { create :task }
  let(:task3) { create :task }

  it "returns all the tasks order by priority"

  it "returns all completed tasks"

  it "returns all hot tasks"

  it "returns all sunny tasks"

  it "returns all cool tasks"

end
