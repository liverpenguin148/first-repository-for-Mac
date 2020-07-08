class TasksController < ApplicationController
include ApplicationHelper
  def create
    @task = current_user.tasks.build(task_param)

    # ステータスごとのタスクを取得
      @task_todo = current_user.tasks.where(finished: "未着手")
      @task_doing = current_user.tasks.where(finished: "対応中").order(start_achievement_date: "ASC")
      @task_done = current_user.tasks.where(finished: "完了").order(finish_achievement_date: "ASC")

    if @task.save
      respond_to do |format|
        format.html { redirect_to pages_show_url }
        format.js
      end
    else
      render 'pages/show'
    end
  end

  def update
    now = Time.now
    if params[:status] == "未着手"
      @task_todo = current_user.tasks.find_by(id: params[:id], user_id: current_user.id)
      working(@task_todo)
    elsif params[:status] == "対応中"
      @task_doing = current_user.tasks.find_by(id: params[:id], user_id: current_user.id)
      finished(@task_doing)
    end
    redirect_to pages_show_url
  end

  def destroy
    @task_done = current_user.tasks.find(params[:id])
    @task_done.destroy
    redirect_to pages_show_url
  end

  private

    def task_param
      params.require(:task).permit(:content, :start_expected_date, :finish_expected_date)
    end
end
