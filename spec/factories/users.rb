FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    name { 'テストゲスト' }
    role { 0 }
    line_user_id { Faker::Code.unique.asin }
    trait :guest_user do
      sequence(:id) { 4697635 }
      name { 'ゲストユーザー' }
      role { 0 }
      line_user_id { 'guest_user' }
    end
  end
end
