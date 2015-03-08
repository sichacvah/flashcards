class ReviewController < ApplicationController
  def index
    @card = current_user.card_for_review
  end

  def review_card
    @card = Card.find(review_params[:card_id])
    check_result = @card.check_translation review_params[:user_input]
    p "!!!!!"
    p check_result
    p "!!!!!"
    if check_result == true
      flash[:success] = "Правильно"
    elsif check_result == :incomplete_match
      flash[:success] = "Опечатка. Вы ввели #{review_params[:user_input]}, а переводом слова #{@card.translated_text} является #{@card.original_text}"
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
