require "rails_helper"
require "support/login"
require "database_cleaner"


describe "the deck card process" do
  before :all do
    DatabaseCleaner.clean
    @user = create(:user, email: "email@email.com",
                          password: "****",
                          password_confirmation: "****",
                          locale: :ru)
    deck = @user.decks.create(name: "Cats")
    card = deck.cards.create(original_text: "Home",
                             translated_text: "Дом")
    card.update_attribute :review_date, Date.today
    login "email@email.com", "****"
  end

  it "create new deck" do
    visit new_deck_path
    fill_in :deck_name, with: "Cats"
    click_button "Создать колоду"
    expect(page).to have_content("Cats")
  end

  it "set current deck" do
    login "email@email.com", "****"
    visit decks_path
    click_link "Сделать текущей"
    expect(page).to have_content("Cats - Текущая Колода")
  end

  it "delete deck" do
    login "email@email.com", "****"
    count = @user.decks.count
    visit decks_path
    click_link "Удалить"
    expect(count - 1).to eq(@user.decks.count)
  end
end
