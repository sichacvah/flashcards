class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to @card, notice: "Book was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
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
    @card = Card.find(params[:id])
  end
end
