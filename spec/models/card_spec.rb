require "rails_helper"
require "database_cleaner"

DatabaseCleaner.strategy = :truncation

describe Card do
  before(:all) do
    DatabaseCleaner.clean
    user = create(:user, email: "email@email.com", password: "****",
                         password_confirmation: "****")
    deck = user.decks.create(name: "Cat")
    @card = deck.cards.create(translated_text: "text",
                              original_text: "текст",
                              user_id: user.id)
  end

  subject { @card }

  describe "has true data in model" do
    it { expect(@card.review_date.to_i).to eq(DateTime.now.to_i) }
    it { expect(@card.translated_text).to eq("text") }
    it { expect(@card.original_text).to eq("текст") }
  end

  describe "is valid first check translation" do
    it { expect(@card.check_translation("текст")).to be true }
    it do
      expect(@card.review_date.to_i).to eq(DateTime.current.to_i + 12.hours.to_i)
    end
  end

  describe "is valid second check translation" do
    it { expect(@card.check_translation("текст")).to be true }
    it do
      expect(@card.review_date.to_i).to eq(DateTime.current.to_i + 3.day.to_i)
    end
  end

  describe "is valid third check translation" do
    it { expect(@card.check_translation("текст")).to be true }
    it do
      expect(@card.review_date.to_i).to eq(DateTime.current.to_i + 1.week.to_i)
    end
  end

  describe "is valid fourth check translation" do
    it { expect(@card.check_translation("текст")).to be true }
    it do
      expect(@card.review_date.to_i).to eq(DateTime.current.to_i + 2.week.to_i)
    end
  end

  describe "is valid fifth check translation" do
    it { expect(@card.check_translation("текст")).to be true }
    it do
      future_date = DateTime.current + 1.month
      expect(@card.review_date.strftime("%Y:%m:%d")).to eq(future_date.strftime("%Y:%m:%d"))
    end
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
    it { expect(Card.for_review.first).to be_valid }
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
