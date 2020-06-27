class TasksController < ApplicationController
  def create
    @task = current_user.tasks.build(task_param)
    if @task.save
      respond_to do |format|
        format.html { redirect_to pages_show_url }
        format.js
      end
    else
      render 'pages/show'
    end
  end

  private

    def task_param
      params.require(:task).permit(:content, :start_expected_date, :finish_expected_date)
    end
end
