FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "free #{n}" }
    sequence(:email) { |n| "free_#{n}@qq.com" }
    password "111111"
    password_confirmation "111111"
  end

  factory :post do
    title "aa"
    content "topic"
    kind "tool"
    user
  end
end