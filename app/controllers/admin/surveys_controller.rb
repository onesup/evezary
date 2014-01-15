class Admin::SurveysController < ApplicationController
  before_action :authenticate_user!
  layout 'admin'
  def index
    @surveys = Survey.all
  end

  def show
    @survey = Survey.find(params[:id])
    @users = @survey.users.order("id desc")
  end
end
