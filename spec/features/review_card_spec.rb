require "rails_helper"
require 'support/review_translation_helper'

describe "the review card process" do
  before do
    card = create(:card, original_text: "Home", translated_text: "Дом")
    card.update_attribute :review_date, Date.today
  end

  it "opens home page" do
    visit root_path
    expect(page).to have_content "Карточка"
  end

  it "true review card" do
    review_translation("Home", "Правильно")
  end

  it "false review card" do
    review_translation("Doom", "Неправильно")
  end
end
