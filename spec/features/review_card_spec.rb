require "rails_helper"

describe "the review card process" do
  let!(:card) { create(:card) }

  it "opens home page" do
    visit root_path
    expect(page).to have_content "Карточка"
  end

  it "true review card" do
    visit root_path
    fill_in :user_input, with: "Home"
    click_button "Проверить"
    expect(page).to have_content "Правильно"
  end

  it "false review card" do
    visit root_path
    fill_in :user_input, with: "Doom"
    click_button "Проверить"
    expect(page).to have_content "Неправильно"
  end
end
