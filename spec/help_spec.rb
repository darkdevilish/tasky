require 'minitest/autorun'
require 'minitest/pride'
require_relative '../help'
require_relative '../task'
require_relative '../action'
require 'factory_girl'
require_relative 'factories'
include FactoryGirl::Syntax::Methods

describe Help do
  before do
    Task.dataset.destroy
  end

  let(:help) { Help.new }
  let(:action) { Action.new }

  describe "when starts" do
    it "outputs a welcome message" do
      welcome_msg = "\n\n**********    Howdy! Welcome to your Tasky    **********\n\n"

      proc { help.welcome_msg }.must_output welcome_msg
    end
  end

  describe "when starts" do
    it "lists valid commands" do
      actions = ["help", "add", "list", "done", "edit", "remove", "quit"]

      proc { help.action_list }.must_output "Actions: #{actions.join(" | ")}\n"
    end
  end

  describe "when starts" do
    it "lists all pending tasks order by priority" do
      2.times do
        create :task
      end
      taske = "1    Task title 1    false    1\n1    Task title 2    false    1\n\n"
      tasks = action.list.each { |task| "#{task.id}   #{task.title}   #{task.completed}    #{task.priority}\n" }

      proc { help.list }.must_output taske
    end
  end
end
