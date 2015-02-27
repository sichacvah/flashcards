FactoryGirl.define do

  factory :card do
    original_text "Home"
    translated_text "Дом"

    after(:create) do |card|
      card.update_attribute(:review_date, Date.today)
    end
  end

end