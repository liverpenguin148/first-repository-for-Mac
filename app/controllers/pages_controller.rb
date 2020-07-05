class PagesController < ApplicationController
  before_action :sign_in_required
  def index
  end

  def show
    @task = current_user.tasks.build if signed_in?
    @tasks = current_user.tasks.all

    if current_user.tasks.any?
      @task_todo = current_user.tasks.where(user_id: current_user.id, finished: "未着手")
      @task_doing = current_user.tasks.where(user_id: current_user.id, finished: "対応中")
      @task_done = current_user.tasks.where(user_id: current_user.id, finished: "完了")
    end
  end

end
