class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(user_params[:email], user_params[:password])
      redirect_to review_path
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to review_path, notice: "Акканут изменён."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
