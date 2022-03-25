FactoryBot.define do
  factory :project do
    sequence(:title) { |n| "project title#{n}" }
    user_id { User.first.id || association(:user) }
  end
end
