class TasksController < ApplicationController
include ApplicationHelper
  def create
    @task = current_user.tasks.build(task_param)

    # ステータスごとのタスクを取得
    get_task

    respond_to do |format|
      if @task.save
        flash.now
        format.html { redirect_to pages_show_url}
        format.js
      else
        format.html {render 'pages/show' }
        format.js
      end
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

    # データ更新後、各種ステータスのデータを取得
    get_task

    # Ajaxでの処理
    respond_to do |format|
      format.html { redirect_to pages_show_url }
      format.js
    end
  end

  def destroy
    @task_done = current_user.tasks.find(params[:id])
    @task_done.destroy

    # データ更新後、各種ステータスのデータを取得
    get_task

    # Ajaxでの処理
    respond_to do |format|
      format.html { redirect_to pages_show_url }
      format.js
    end
  end

  private

    def task_param
      params.require(:task).permit(:content, :start_expected_date, :finish_expected_date)
    end

    # 各種ステータスのデータを取得
    def get_task
      @task_todo = current_user.tasks.where("finished = ?", "未着手")
      @task_doing = current_user.tasks.where("finished = ?", "対応中").order(start_achievement_date: "ASC")
      @task_done = current_user.tasks.where("finished = ?", "完了").order(finish_achievement_date: "ASC")
    end

end
