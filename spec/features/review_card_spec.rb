require "rails_helper"
require "support/login"


describe "the review card process" do
  before do
    user = create(:user, email: "email@email.com", password: "****",
                         password_confirmation: "****")
    card = user.cards.create(original_text: "Home", translated_text: "Дом")
    card.update_attribute :review_date, Date.today
    login "email@email.com", "****"
  end

  it "true review card" do
    visit review_path
    fill_in :user_input, with:"Home"
    click_button "Проверить"
    expect(page).to have_content("Правильно")
  end

  it "false review card" do
    visit review_path
    fill_in :user_input, with:"Doom"
    click_button "Проверить"
    expect(page).to have_content("Неправильно")
  end
end

describe "no cards" do
  before do
    user = create(:user, email: "email@email.com", password: "****",
      password_confirmation: "****")
    login "email@email.com", "****"
  end
  it "no cards" do
    visit review_path
    expect(page).to have_content "У вас нет ни одной карточки для просмотра"
  end
end
