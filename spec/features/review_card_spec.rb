require "rails_helper"
require "support/login"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation

describe "the review card process" do
  before do
    Capybara.current_session.driver.
      headers = { "Accept-Language" => "ru" }
    DatabaseCleaner.clean
    user = create(:user, email: "email@email.com",
                         password: "****",
                         password_confirmation: "****")
    deck = user.decks.create(name: "Cats")
    card = deck.cards.create(original_text: "Home",
                             translated_text: "Дом",
                             user_id: user.id)
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
    fill_in :user_input, with: "ADFG"
    click_button "Проверить"
    expect(page).to have_content("Неправильно")
  end
end

describe "no cards" do
  before do
    DatabaseCleaner.clean
    user = create(:user, email: "email@email.com", password: "****",
                         password_confirmation: "****")
    login "email@email.com", "****"
  end
  it "no cards" do
    visit review_path
    expect(page).to have_content "У вас нет ни одной карточки для просмотра"
  end
end
