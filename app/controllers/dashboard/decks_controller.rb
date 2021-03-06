class Dashboard::DecksController < ApplicationController
  before_action :set_deck, only: [:update, :destroy, :edit, :set_current]

  def index
    flash.clear
    @decks = current_user.decks.all
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = current_user.decks.new(deck_params)
    if @deck.save
      redirect_to deck_cards_path(@deck), notice: "Колода создана."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @deck.update_attributes(deck_params)
      redirect_to decks_path, notice: "Карточка изменена."
    else
      render :edit
    end
  end

  def set_current
    if current_user.update_attributes(current_deck_id: @deck.id)
      redirect_to decks_path, notice: "Текущая колода изменена."
    else
      redirect_to decks_path, notice: "Ошибка."
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path
  end

  protected

  def set_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name)
  end
end
