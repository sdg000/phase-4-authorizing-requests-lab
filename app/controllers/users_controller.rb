class UsersController < ApplicationController

  # returns a specific user instance based on their session[:user_id]
  def show
    user = User.find(session[:user_id])
    render json: user
  end

end
