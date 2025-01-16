class TasksController < ApplicationController
  before_action :require_login, :set_task, only: [:toggle_completed]

  def toggle_completed
    @task.update(completed: params[:completed])
    redirect_to tasks_path, notice: "Task updated successfully!"
  end


  def index
    @task = current_user.tasks  # Fetch tasks for the logged-in user
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'Task created successfully.'
    else
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])  # Ensure the task belongs to the user
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: 'Task deleted successfully.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed, :date)
  end

  def require_login
    unless current_user
      redirect_to new_session_path, alert: 'You must be logged in to access this section.'
    end
  end
end
