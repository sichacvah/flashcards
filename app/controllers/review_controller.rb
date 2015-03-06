class ReviewController < ApplicationController
  helper_method :current_deck
  def index
    if current_deck.nil?
      @card = current_user.cards.for_review.first
    else
      @card = current_deck.cards.for_review.first
    end
  end

  def review_card
    @card = Card.find(review_params[:card_id])
    if @card.check_translation review_params[:user_input]
      flash[:success] = "Правильно"
    else
      flash[:danger] = "Неправильно"
    end
    redirect_to review_path
  end

  private

  def current_deck
    @current_deck ||= current_user[:current_deck]
  end

  def review_params
    params.permit(:card_id, :user_input)
  end
end
