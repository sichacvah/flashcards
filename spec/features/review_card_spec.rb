require "rails_helper"

def review_translation(text, result)
  visit root_path
  fill_in :user_input, with: text
  click_button "Проверить"
  expect(page).to have_content(result)
end

describe "the review card process" do
  before do
    card = create(:card, original_text: "Home", translated_text: "Дом")
    card.update_attribute :review_date, Date.today
  end

  it "true review card" do
    review_translation("Home", "Правильно")
  end

  it "false review card" do
    review_translation("Doom", "Неправильно")
  end
end
