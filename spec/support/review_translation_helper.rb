def review_translation(text, result)
  visit root_path
  fill_in :user_input, with: text
  click_button "Проверить"
  expect(page).to have_content(result)
end