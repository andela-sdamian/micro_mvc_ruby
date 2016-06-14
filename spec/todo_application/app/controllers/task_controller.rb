class TaskController < ApplicationController 
  def index 
    @pending = Task.where("status like ?", "%pending%")
    @done = Task.where("status like ?", "%done%")
  end

  def new
    @task = Task.new 
  end

  def show
    @task = Task.find(params["id"])
  end

  def edit
    @task = Task.find(params["id"])
  end

  def create
    task_params = params["task"]
    @task = Task.new
    @task.title = task_params["title"]
    @task.body = task_params["body"]
    @task.status = task_params["status"]
    @task.created_at = Time.now.to_s
    @task.save

    redirect_to "/task/#{Task.last.id}"
  end

  def update
    task_params = params["task"]
    @task = Task.find(params["id"])
    @task.update(title: task_params["title"], body: task_params["body"], status: task_params["status"])
    redirect_to "/task/#{@task.id}"
  end

  def destroy
    @task = Task.find(params["id"])
    @task.destroy

    redirect_to "/"
  end

  def teaser(str)
    if str.size < 20 
      str 
    else 
      str[0, 20] + '...'
    end 
  end 
end
