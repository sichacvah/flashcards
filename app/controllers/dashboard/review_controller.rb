class Dashboard::ReviewController < ApplicationController
  def index
    @card = current_user.card_for_review
    respond_to do |format|
      if @card.present?
        format.html
        format.json do
          render json: { id: @card.id, image_url: @card.image.url(:medium),
                         translated_text: @card.translated_text }
        end
      else
        flash[:info] = t(:not_cards)
        format.html
        format.json { render json: { message: flash }.to_json }
      end
    end
  end

  def review_card

    @card = Card.find(review_params[:card_id])
    check_result = @card.check_translation review_params[:user_input], review_params[:time_to_answer]
    respond_to do |format|
      set_flash(check_result)
      format.html { redirect_to review_path }
      format.json { render json: { message: flash }.to_json }
    end
  end

  private

  def set_flash(check_result)
    if check_result == :success
      flash[:success] = t(:success)
    elsif check_result == :incomplete_match
      flash[:warning] = t(:missprint, user_input: review_params[:user_input],
                                      translate: @card.translated_text,
                                      original: @card.original_text)
    elsif check_result == :failed
      flash[:danger] = t(:fail)
    end
  end

  def review_params
    params.permit(:card_id, :user_input, :time_to_answer)
  end
end
