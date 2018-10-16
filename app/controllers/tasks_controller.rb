class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]
  def create
    @task = Task.new(task_params)
    if @task.save
      render json: { success: true, data: { task: @task }, error: [] }
    else
      render json: { success: false, data: { }, error: [@task.errors.full_messages] }
    end
  end

  def index
    @tasks = Task.all
    render json: { success: true, data: { tasks: @tasks }, error: [] }
  end

  def update
    if @task.update(task_params)
      render json: { success: true, data: { task: @task }, error: [] }
    end
  end

  def destroy
    if @task.destroy
      render json: { success: true, data: { }, error: [] }
    end
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      render json: { success: true, data: {}, error: ["There is no advertisement with id #{params[:task_id]}."]}, status: :not_found and return
    end
  end

  def task_params
    params.require(:task).permit(:name, :status)
  end
end
