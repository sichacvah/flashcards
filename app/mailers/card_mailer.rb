class CardMailer < ActionMailer::Base
  default from: "sichirc@gmail.com"

  def pending_cards_notification(user, cards_for_review_count)
    @user = user
    @cards_for_review_count = cards_for_review_count
    mail(to: @user.email, subject: "У вас есть не проверенные карточки.")
  end
end
