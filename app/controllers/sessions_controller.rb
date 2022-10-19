class SessionsController < ApplicationController
  
  #login
  # finds a user instance by username, if found, save their user_id to sessions , logs user in
  def create
    user = User.find_by(username: params[:username])
    session[:user_id] = user.id
    render json: user
  end

  #logout
  #deletes a user's user_id from sessions, logs them out
  def destroy
    session.delete :user_id
    head :no_content
  end

end
