require "rails_helper"
require "database_cleaner"
require "support/card_dummy"
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
    @card_dummy = CardDummy.new
    @card_dummy.set_items
    @super_memo = SuperMemo.new(@card_dummy, 5)
  end

  subject { @card }

  describe "has true data in model" do
    it do
      expect(@card.review_date.strftime("%Y:%m:%d-%H:%M")).
        to eq(DateTime.current.strftime("%Y:%m:%d-%H:%M"))
    end
    it "valid translated text" do
      expect(@card.translated_text).to eq("text")
    end
    it "valid original text" do
      expect(@card.original_text).to eq("текст")
    end
    it "first check" do
      expect(@card.check_translation("текст")).to eq(:success)
    end
    it "valid first review date" do
      @super_memo = SuperMemo.new(@card_dummy, 5)
      @card_dummy.set_items(@super_memo.get_repetition)
      expect(@card.review_date.strftime("%Y:%m:%d:%H:%M")).
        to eq(@card_dummy.review_date.strftime("%Y:%m:%d:%H:%M"))
    end
    it "second check" do
      expect(@card.check_translation("текст")).to eq(:success)
    end
    it "valid second review date" do
      @super_memo = SuperMemo.new(@card_dummy, 5)
      @card_dummy.set_items(@super_memo.get_repetition)
      expect(@card.review_date.strftime("%Y:%m:%d-%H:%M")).
        to eq(@card_dummy.review_date.strftime("%Y:%m:%d-%H:%M"))
    end
    it "third check" do
      expect(@card.check_translation("текст")).to eq(:success)
    end
    it "valid  third review date" do
      @super_memo = SuperMemo.new(@card_dummy, 5)
      @card_dummy.set_items(@super_memo.get_repetition)
      expect(@card.review_date.strftime("%Y:%m:%d-%H:%M")).
        to eq(@card_dummy.review_date.strftime("%Y:%m:%d-%H:%M"))
    end
    it "valid fourth check" do
      expect(@card.check_translation("текст")).to eq(:success)
    end
    it "valid forth review date" do
      @super_memo = SuperMemo.new(@card_dummy, 5)
      @card_dummy.set_items(@super_memo.get_repetition)
      expect(@card.review_date.strftime("%Y:%m:%d-%H:%M")).
        to eq(@card_dummy.review_date.strftime("%Y:%m:%d-%H:%M"))
    end
    it "is invalid check tranlation" do
      expect(@card.check_translation("письмо")).to eq(:failed)
    end
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
