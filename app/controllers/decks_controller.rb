class DecksController < ApplicationController
  def index
    @decks = current_user.decks.all
  end

  def show
    @deck = current_user.decks.find(params[:id])
    redirect_to deck_cards_path(@deck)
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = current_user.decks.new(deck_params)
    if @deck.save
      redirect_to @deck, notice: "Колода создана."
    else
      render :new
    end
  end

  def edit
  end


  def update
    @deck = Deck.find(params[:id])
    if @deck.update_attribute(:current, !@deck.current)
      @deck.falsify_all_others
      redirect_to decks_path, notice: "Текущая колода изменена."
    else
      redirect_to decks_path, notice: "Ошибка."
    end
  end

  def destroy
    @deck = Deck.find(params[:id]).destroy
    redirect_to decks_path
  end

  protected

  def deck_params
    params.require(:deck).permit(:name, :current)
  end

end