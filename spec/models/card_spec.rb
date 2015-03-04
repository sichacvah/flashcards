require "rails_helper"

describe Card do
  before do
    User.destroy_all
    user = create(:user, email: "email@email.com", password: "****",
                         password_confirmation: "****")
    deck = user.decks.create(name: "Cat")
    @card = deck.cards.create(translated_text: "text", original_text: "текст")
  end

  subject { @card }

  describe "has true data in model" do
    it { expect(@card.review_date).to eq(Date.today + 3.days) }
    it { expect(@card.translated_text).to eq("text") }
    it { expect(@card.original_text).to eq("текст") }
  end

  describe "is valid check translation" do
    it { expect(@card.check_translation("текст")).to be true }
    it { expect(@card.review_date).to eq(Date.today + 3.days) }
  end

  it "is invalid check tranlation" do
    expect(@card.check_translation("письмо")).to be false
  end

  describe "not empty" do
    before do
      @card = User.first.decks.first.cards.create(
        translated_text: "text",
        original_text: "текст",
        user_id: User.first.id)
      @card.update_attribute(:review_date, Date.today)
    end
    it { expect(Card.cards_for_review.first).to be_valid }
  end

  describe "when translated text is not present" do
    before { @card.translated_text = "" }
    it { expect(@card).to_not be_valid }
  end

  describe "when original text is not present" do
    before { @card.original_text = "" }
    it { expect(@card).to_not be_valid }
  end

  describe "when original text equal translated text" do
    before do
      @card.original_text = "equal"
      @card.translated_text = "   EqUaL    "
    end
    it { expect(@card).to_not be_valid }
  end

  after(:all) { Card.destroy_all }
end
