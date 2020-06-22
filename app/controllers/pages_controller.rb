class PagesController < ApplicationController
  def index
  end

  def show
    debugger
    @task = current_user.tasks.build if signed_in?
  end
end
