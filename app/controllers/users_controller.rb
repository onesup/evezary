class UsersController < ApplicationController
  def show
  end
  def create
    @user = User.new(user_params)
    @user.phone = params[:phone1] + "-" + params[:phone2] + "-" + params[:phone3]
    result = false if User.exists?(phone: @user.phone) == 1
    @user.survey = Survey.find_by_code(params[:survey])
    unless result == false
      @user.save
    end
    respond_to do |format|
      format.html {render nothing: true}
      format.json {render json: data}
    end
  end
  
  def tracking_log
    user = User.find_by_blog_code params[:id]
    user.viral_score += 1
    user.save
    data = {score: user.viral_score}
    respond_to do |format|
      format.html {redirect_to root_path}
      format.json {render json: data}
    end
  end
  
  def is_surveyed
    result = false
    result = true if User.exists?(phone: params[:id]) == 1
    if result == true
      user = User.where(phone: params[:id]).first
      data = {result: result, name: user.name, blog_code: user.blog_code}
    else
      user = User.new
      data = {result: result}
    end
    respond_to do |format|
      format.json {render json: data}
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :email, :password, :blog_code)
  end
end