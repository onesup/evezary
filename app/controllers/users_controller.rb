class UsersController < ApplicationController
  def show
  end
  def create
    @user = User.new(user_params)
    @user.phone = params[:phone1] + "-" + params[:phone2] + "-" + params[:phone3]
    result = true
    result = false if User.exists?(phone: @user.phone) == 1
    new_year = Time.now.beginning_of_year
    end_of_event = (new_year + 26.days).end_of_day
    @user.survey = Survey.find_by_code(params[:survey])
    if Time.now < end_of_event
      if result == true
        @user.save
      end
    end
    respond_to do |format|
      format.html {render nothing: true}
      format.json {render json: data}
    end
  end
  
  def tracking_log
    user = User.find_by_blog_code params[:id]
    unless user.nil?
      user.viral_score += 1
      user.save
      data = {score: user.viral_score}
      respond_to do |format|
        format.html {redirect_to root_path}
        format.json {render json: data}
      end
    else
      data = {score: 0}
      respond_to do |format|
        format.html {redirect_to root_path}
        format.json {render json: data}
      end
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
    new_year = Time.now.beginning_of_year
    end_of_event = (new_year + 26.days).end_of_day
    if end_of_event < Time.now
      data = {result: "timeover"}
    end
    Rails.logger.info("@@@@"+data.to_s)
    respond_to do |format|
      format.json {render json: data}
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :email, :password, :blog_code)
  end
end

