class ReviewController < ApplicationController
  def index
    current_deck = current_user.current_deck_id
    unless current_deck.nil?
      @card = current_user.decks.find(current_deck).cards.cards_for_review.first
    else
      @card = current_user.cards.cards_for_review.first
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

  def review_params
    params.permit(:card_id, :user_input)
  end
end
