class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :set_deck

  def show
  end

  def index
    @cards = @deck.cards
  end

  def new
    @card = @deck.cards.new
  end

  def create
    params = card_params
    p params[:user_id] = current_user.id
    @card = @deck.cards.new(params)
    if @card.save!
      puts @card.id
      redirect_to [@deck, @card], notice: "Карточка создана."
    else
      render :new
    end
  end

  def update
    if @card.update_attributes(card_params)
      redirect_to deck_card_path, notice: "Карточка изменена."
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to deck_cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image)
  end

  def set_deck
    @deck = current_user.decks.find(params[:deck_id])
  end

  def set_card
    set_deck
    @card = @deck.cards.find(params[:id])
  end
end
