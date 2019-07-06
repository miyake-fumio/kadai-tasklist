class TasksController < ApplicationController
  
 before_action :set_task, only: [:show, :edit, :update, :destroy]
    
 def index
    @tasks = Task.all
 end

 def show
 end

 def new
    @task = Task.new(content: 'いつものタスク')
 end

 def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'タスク が追加されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク が追加されませんでした'
      render :new
    end
 end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content)
  end

  def edit
  end

  def update

    if @task.update(task_params)
      flash[:success] = 'タスク は正常に修正されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は修正されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'タスク は正しく削除されました'
    redirect_to tasks_url
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content,:status)
  end
  
end

