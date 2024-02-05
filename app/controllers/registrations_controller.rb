# frozen_string_literal: true

# Controller for the Registration resource
class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # params => {"authenticity_token"=>"[FILTERED]", "user"=>{"email"=>"andressa.pamachado@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "commit"=>"Sign Up"}
    # params[:user] => {"email"=>"andressa.pamachado@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Successfully created account'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    # it requires a user object and only permits an email, a password and a password_confirmation to be set
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
