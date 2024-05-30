FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    name { 'テストゲスト' }
    role { 0 }
    line_user_id { Faker::Code.unique.asin }
  end
end
