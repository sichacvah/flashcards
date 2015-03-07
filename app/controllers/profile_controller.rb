class ProfileController < ApplicationController
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
