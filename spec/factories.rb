FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task title #{n}" }
    description "Description"
    completed false
    priority n
  end
end
