require "rails_helper"

RSpec.describe Card, type: :model do
  before do
    @card = Card.create(translated_text: "text", original_text: "текст")
  end

  subject { @card }

  it { should respond_to(:translated_text) }
  it { should respond_to(:original_text) }
  it { should respond_to(:review_date) }
  it { should be_valid }

  describe "has true data in model" do
    it { expect(@card.review_date).to eq(Date.today + 3.days) }
    it { expect(@card.translated_text).to eq("text") }
    it { expect(@card.original_text).to eq("текст") }
  end

  it "is valid check translation" do
    expect(@card.check_translation("текст")).to be true
    expect(@card.review_date).to eq(Date.today + 6.days)
  end

  it "is invalid check tranlation" do
    expect(@card.check_translation("письмо")).to be false
  end

  describe "not empty" do
    before { Card.cards_for_review.first }
    it { should be_valid }
  end

  describe "when translated text is not present" do
    before { @card.translated_text = "" }
    it { should_not be_valid }
  end

  describe "when original text is not present" do
    before { @card.original_text = "" }
    it { should_not be_valid }
  end

  describe "when original text equal translated text" do
    before do
      @card.original_text = "equal"
      @card.translated_text = "   EqUaL    "
    end
    it { should_not be_valid }
  end

  after(:all) { Card.destroy_all }
end
