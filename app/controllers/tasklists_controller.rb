class TasklistsController < ApplicationController
    before_action :set_tasklist, only: [:show, :edit, :update, :destroy]
    
    def index
     if logged_in?
         @user = current_user
         @tasklist = current_user.tasklists.build
         @tasklists = current_user.tasklists.order('created_at DESC').page(params[:page])
     end
    end
    def show
        set_tasklist
    end
    def new
        @tasklist = Tasklist.new
    end
    def create
        @tasklist = current_user.tasklists.build(tasklist_params)
        
        if @tasklist.save
            flash[:success] = "タスクが正常に登録されました"
            redirect_to @tasklist
        else
            flash.now[:danger] = "タスクが登録されませんでした"
            render :new
        end
    end
    def edit
        set_tasklist
    end
    def update
        set_tasklist
        
        if @tasklist.update(tasklist_params)
            flash[:success] = 'タスクは正常に更新されました'
            redirect_to @tasklist
        else
            flash.now[:danger] = 'タスクは更新されませんでした'
            render :edit
        end
    end
    def destroy
        set_tasklist
        @tasklist.destroy
        
        flash[:success] = 'タスクは正常に削除されました'
        redirect_to tasklists_url
    end
    
    private
    def set_tasklist
        @tasklist = Tasklist.find(params[:id])
    end
    
    def tasklist_params
        params.require(:tasklist).permit(:Content, :status)
    end
end
