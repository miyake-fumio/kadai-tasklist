class TasksController < ApplicationController
 before_action :require_user_logged_in 
# before_action :set_task, only: [:show, :edit, :update, :destroy]
# before_action :require_user_logged_in, only: [:create, :edit, :update, :destroy, :index, :show]
 before_action :correct_user, only: [:edit, :update, :destroy, :show]
    
 def index
#    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc)
#    end
 end

 def show
 end

 def new
    @task = Task.new(content: 'いつものタスク')
 end

 def create
    @task = current_user.tasks.build(task_params)
    # @task = Task.new(task_params)
    # @task.user_id = current_user.id
    # @task.user = current_user

    if @task.save
      flash[:success] = 'タスク が追加されました'
      redirect_to root_url
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
      redirect_to root_url
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
    # find(対象のidが入る)は、対象のデータが無ければエラーを出す。
    # find_by(id: 対象のidが入る)、対象のデータが無ければnilを返す。
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content,:status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    # @task = Task.find_by(id: params[:id])
    # if @task.nil? || @task.user != current_user
    #   redirect_to root_url
    # end
    unless @task
      redirect_to root_url
    end
  end


end

