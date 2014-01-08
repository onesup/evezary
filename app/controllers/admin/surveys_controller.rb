class Admin::SurveysController < ApplicationController
  layout 'admin'
  def index
    @surveys = Survey.all
  end

  def show
    @survey = Survey.find(params[:id]).users
  end
end
