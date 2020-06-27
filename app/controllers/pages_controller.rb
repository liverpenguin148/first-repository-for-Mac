class PagesController < ApplicationController
  def index
  end

  def show
    @task = current_user.tasks.build if signed_in?
    @tasks = current_user.tasks.order(start_expected_date: :desc)
  end
end
