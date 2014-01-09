class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.phone = params[:phone1] + "-" + params[:phone2] + "-" + params[:phone3]
    @user.survey = Survey.find_by_code(params[:survey])
    @user.save
    respond_to do |format|
      format.html {render nothing: true}
      format.json {render json: data}
    end
  end
  
  def tracking_code
    code = User.random_code
    data = {code: code}
    respond_to do |format|
      format.html {render nothing: true}
      format.json {render json: data}
    end
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :email, :password, :blog_code)
  end
end