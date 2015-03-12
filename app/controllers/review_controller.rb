class ReviewController < ApplicationController
  def index
    @card = current_user.card_for_review
  end

  def review_card
    @card = Card.find(review_params[:card_id])
    check_result = @card.check_translation review_params[:user_input], review_params[:time_to_answer]
    @card = current_user.card_for_review
    respond_to do |format|
      flash.clear
      if check_result == :success
        flash[:success] = t(:success)
      elsif check_result == :incomplete_match
        flash[:warning] = t(:missprint, user_input: review_params[:user_input],
                                        translate: @card.translated_text,
                                        original: @card.original_text)
      elsif check_result == :failed
        flash[:danger] = t :fail
      end
      format.html { redirect_to review_path }
      format.js {}
    end
  end

  private

  def review_params
    params.permit(:card_id, :user_input, :time_to_answer)
  end
end
