# frozen_string_literal: true

# Controller for the Registration resource
class RegistrationsController < ApplicationController
  # Create a new user instance
  def new
    @user = User.new
  end

  # Create a new user with the given parameters from form
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Successfully created account'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Define the parameters required for a user
  def user_params
    # it requires a user object and only permits an email, a password and a password_confirmation to be set
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
