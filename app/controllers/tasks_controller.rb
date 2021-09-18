class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
      #終了期限・優先順位で昇降ソート
      if params[:sort_expired]
        @tasks = Task.all.order('deadline DESC')
      elsif params[:sort_priority]
        @tasks = Task.all.order('priority ASC')
      else
        @tasks = Task.all
      end

      #タイトル名の検索
      if params[:search].present?
        @tasks = Task.where("title LIKE ?","%#{params[:search][:title]}%") 
      end

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
        if @task.update(task_params)
          redirect_to tasks_path, notice: "Task was successfully updated!"
        else
          render :edit
        end
    end

    def destroy
        @task.destroy
        redirect_to tasks_path, notice:"Task was successfully deleted!"
    end

    private
    def task_params
        params.require(:task).permit(:title, :content, :deadline, :status, :priority)
    end

    def set_task
        @task = Task.find(params[:id])
    end
end
