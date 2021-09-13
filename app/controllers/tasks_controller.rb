class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
        @tasks = Task.all
    end

    def show
    end

    def new
        @task = Task.new
    end
    
    def edit
    end

    def create
        @task = Task.new(task_params)
        if @task.save
          redirect_to tasks_path, notice: "Task was successfully created!"
        else
          render :new
        end
    end

    def update
    end

    def destroy
    end

    private
    def task_params
        params.require(:task).permit(:title, :content)
    end

    def set_task
        @task = Task.find(params[:id])
    end
end