FactoryGirl.define do
  factory :user do
    factory :user_with_cards do
      after(:create) do |user|
        create(:card, user: user)
      end
    end
  end
end

