# frozen_string_literal: true

# SessionsController is responsible for handling user login and logout.
# It is used to authenticate the user and store the user's ID in the session.
# It also provides a method to destroy the session and log the user out.
class SessionsController < ApplicationController
  def new; end

  # Create a new session by finding the user by username and authenticating the password.
  def create
    @user = User.find_by(username: params[:username])

    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in successfully!"
    else
      flash[:notice] = "Invalid username or password"
      render :new, status: :unprocessable_entity
    end
  end

  # Destroy the session and log the user out.
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
