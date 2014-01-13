class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  layout 'admin'
  
  def index
    @users = User.order("id desc")
  end

  def show
    @user = User.find(params[:id])
  end
end
