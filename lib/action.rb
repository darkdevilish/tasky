class Action
  class Config
    ACTIONS = {
      :h => :help,
      :a => :add,
      :l => :list,
      :s => :show,
      :d => :done,
      :r => :remove,
      :q => :quit
    }

    def self.actions ; ACTIONS ; end
  end

  attr_writer :input

  def initialize(input="")
    @input = input
  end

  def valid_action?
    if short_action_name?
      Action::Config.actions.include?(@input.to_sym)
    else
      Action::Config.actions.has_value?(@input.to_sym)
    end
  end

  def short_action_name?
    if @input.length == 1
      true
    else
      false
    end
  end

  def run
    if valid_action?
      if short_action_name?
        Object.const_get(Action::Config.actions[@input.to_sym].to_s.capitalize).new.run
      else
        Object.const_get(@input.capitalize).new.run
      end
    else
      invalid_action
    end
  end

  def invalid_action
    print "\n" + "*" * 12 + " " * 3 + "Invalid Command" + " " * 3 + "*" * 12 + "\n\n"
  end

 end
