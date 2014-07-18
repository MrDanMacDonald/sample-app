class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      @session = Session.new(id: @user.id)
    else
      flash.now[:alert] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy

  end
end
