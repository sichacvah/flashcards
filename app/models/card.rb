class Card < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>" }
  # has_attached_file :download,
  #                    storage: :s3,
  #                    s3_credentials: Proc.new{|a| a.instanace}
  belongs_to :user
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :original_text, :translated_text, :review_date, :user,
            presence: true
  validate :words_equal?
  before_validation :set_review_date, if: :new_record?

  scope :cards_for_review, -> {
    where("review_date <= ?", Date.today).order("RANDOM()")
  }

  # def s3_credentials
  #   {bucket: 'sichacvah', access_key_id: ENV["AWS_ACCESS_KEY_ID"], access_secret_key: ENV["AWS_SECRET_KEY_ID"]}
  # end

  def check_translation(user_input)
    if prepare_word(user_input) == prepare_word(original_text)
      update_attribute(:review_date, review_date + 3.days)
    else
      false
    end
  end

  protected

  def set_review_date
    self.review_date = Date.today + 3.days
  end

  def prepare_word(word)
    word.squish.mb_chars.downcase.to_s
  end

  def words_equal?
    if prepare_word(original_text) == prepare_word(translated_text)
      errors.add(:original_text, "original text can't be equal transalted text ")
      errors.add(:translated_text, "translated text can't be equal original text")
    end
  end
end
