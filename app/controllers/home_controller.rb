class HomeController < ApplicationController
  before_action :set_card, only: :index

  def index
  end

  def review_card
    @card = Card.find(review_params[:card_id])
    if @card.check_translation? review_params[:user_input]
      flash[:success] = "Правильно"
    else
      flash[:danger] = "Неправильно"
    end
    redirect_to root_url
  end

  private

  def set_card
    @card = Card.cards_for_review.first
  end

  def review_params
    params.permit(:card_id, :user_input)
  end
end
