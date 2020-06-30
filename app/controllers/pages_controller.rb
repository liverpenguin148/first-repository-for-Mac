class PagesController < ApplicationController
  before_action :sign_in_required
  def index
  end

  def show
    @task = current_user.tasks.build if signed_in?
    @tasks = current_user.tasks.all
  end
end
