class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @cards = current_user.cards
  end

  def new
    @card = Card.new
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      redirect_to @card, notice: "Карточка создана."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @card.update_attributes(card_params)
      redirect_to @card, notice: "Карточка изменена."
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end

  def set_card
    @card = current_user.cards.find(params[:id])
  end
end
