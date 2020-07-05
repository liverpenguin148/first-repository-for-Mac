class TasksController < ApplicationController
  def create
    @task = current_user.tasks.build(task_param)
    # 表示したいレコードを取得する
    @tasks = current_user.tasks.all

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
    @task_todo = current_user.tasks.find_by(id: params[:task_id], user_id: current_user.id)
    @task_todo.update_attribute(:finished,"対応中")

    @task_doing = current_user.find_by(id: params[:task_id], user_id: current_user.id)
    @task_doing.update_attribute(:finished,"完了")
  end

  def destroy
    @task_done = current_user.tasks.find(params[:task_id])
    @task_done.destroy
  end

  private

    def task_param
      params.require(:task).permit(:content, :start_expected_date, :finish_expected_date)
    end
end
