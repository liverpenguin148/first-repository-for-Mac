class TasksController < ApplicationController
  def create
    @task = current_user.tasks.build(task_param)
    if @task.save
      redirect_to @user
    else
    end
  end

  private

    def task_param
      params.require(:task).permit(:content, :start_expected_date, :finish_expected_date)
    end
end
