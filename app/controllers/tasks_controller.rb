class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]
  def create
    @task = Task.new(task_params)
    if @task.save
      render json: {success: true, data: TaskSerializer.new(@task).serializable_hash[:data], errors: [] }, status: :created
    else
      render json: { success: false, data: { }, errors: [@task.errors.full_messages] }
    end
  end

  def index
    @tasks = Task.all
    render json: { success: true, data: TaskSerializer.new(@tasks).serializable_hash[:data], errors: [] }
  end

  def update
    if @task.update(task_params)
      render json: { success: true, data: TaskSerializer.new(@task).serializable_hash[:data], errors: [] }
    end
  end

  def destroy
    if @task.destroy
      render json: { success: true, data: { }, errors: [] }
    end
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      render json: { success: true, data: {}, errors: ["There is no advertisement with id #{params[:task_id]}."]}, status: :not_found and return
    end
  end

  def task_params
    params.require(:task).permit(:name, :status)
  end
end
