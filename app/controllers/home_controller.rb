class HomeController < ApplicationController
  before_action :set_card, only: :index

  def index
  end

  def check_answer
    
    if Card.check_input(card_params)
      flash[:success] = "Правильно"
    else
      flash[:danger] = "Неправильно"
    end
    redirect_to root_url
  end

  private


  def set_card
    @card = Card.get_random_card
  end

  def card_params
    params.permit(:user_input, :id)
  end
end
