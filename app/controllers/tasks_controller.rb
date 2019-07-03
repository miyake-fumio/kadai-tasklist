class TasksController < ApplicationController
    
 def index
    @tasks = Task.all
 end

 def show
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスク は正常に修正されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は修正されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスク は正しく削除されました'
    redirect_to tasks_url
  end
end


