class SubmitRequestsController < ApplicationController
  before_action :set_submit_request, only: [:show, :edit, :update, :destroy ]
  before_action :set_submit_request02, only: [:approve, :unapprove, :reject]
  before_action :authenticate_user!
  
  def index
    #自分が依頼したものが表示される
    @submit_requests = SubmitRequest.where(user_id: current_user.id).order(updated_at: :desc)
  end

  def new
    #つながっているユーザー
    friendsQuery = "select * FROM (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.followed_id WHERE relationships.follower_id = " + current_user[:id].to_s + ") X INNER JOIN (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.follower_id WHERE relationships.followed_id = " + current_user[:id].to_s + ") Y ON X.id = Y.id"
    @users = User.find_by_sql(friendsQuery)
    
    #binding.pry

    #自分が作成したタスク
    @tasks = Task.where.not(id: SubmitRequest.select(:task_id)).where(user_id: current_user.id, done: false)
    #binding pry
    #リクエスト新規作成用
    #@submit_request = current_user.submit_requests.build(status: 1)
    @submit_request = SubmitRequest.new(user_id: current_user[:id], status: 1)
    @user = @submit_request.user
  end

  def create
    @submit_request = SubmitRequest.new(submit_request_params)
    #@task = Task.find(submit_request_params[:task_id])
    #binding.pry
   respond_to do |format|
      if @submit_request.save
        #保存できたら、依頼対象のタスク担当者を依頼先のユーザーに更新する
        @submit_request.task.update(status: 1, charge_id: submit_request_params[:charge_id])
        
        format.html { redirect_to @submit_request, notice: '依頼しました' }
        format.json { render :show, status: :created, location: @submit_request }
      else
        format.html { render :new }
        format.json { render json: @submit_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
    #つながっているユーザー
    friendsQuery = "select * FROM (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.followed_id WHERE relationships.follower_id = " + current_user[:id].to_s + ") X INNER JOIN (SELECT users.* FROM users INNER JOIN relationships ON users.id = relationships.follower_id WHERE relationships.followed_id = " + current_user[:id].to_s + ") Y ON X.id = Y.id"
    @users = User.find_by_sql(friendsQuery)
    
    #@test = @submit_request
    #binding.pry
    
    #taskのidがSubmitRequestのtask_idでなく、かつ自分が作成した(user_idがcurrent_user.id) 未完成(doneがfalse)のタスク
    #@tasks = Task.where.not(id: SubmitRequest.select(:task_id)).where(user_id: current_user.id, done: false)
    
    #選択されたタスク
    @tasks = Task.where.not(id: SubmitRequest.select(:task_id)).where(user_id: current_user.id, done: false)
  end

  def update
     respond_to do |format|
      if @submit_request.update(submit_request_params)
        
        #依頼管理にひもずくタスクの担当者も更新される
        @submit_request.task.update(charge_id: submit_request_params[:charge_id])
        format.html { redirect_to @submit_request, notice: '更新しました' }
        format.json { render :show, status: :ok, location: @submit_request }
      else
        format.html { render :edit }
        format.json { render json: @submit_request.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def destroy
  end

  def approve
    #@submit_request = SubmitRequest.find(params[:submit_request_id])
    #承認進み
    @submit_request02.update(status: 2)
    #依頼にひもずくタスクのステータスを承認にする
    @submit_request02.task.update(status: 2)
    #現在依頼した本人が担当者になっている一覧を表示
    @Submit_Requests = SubmitRequest.where(charge_id: current_user.id).order("updated_at DESC")
    
    respond_to do |format|
    format.html { redirect_to  inbox_user_submit_requests_path(current_user.id) , notice: '承認しました' }
    format.js
      
      #format.html
     end
    
  end

  def unapprove
    #承認を却下
    @submit_request02.update(status: 9)
    #binding.pry
    #依頼にひもずくタスクの承認を却下し担当者を依頼主にもどす
    @submit_request02.task.update(status: 9, charge_id: @submit_request02.user_id)

    #現在依頼した本人が担当者になっている一覧を表示
    @submit_requests = SubmitRequest.where(charge_id: current_user.id).order("updated_at DESC")
    
    respond_to do |format|
     format.html { redirect_to inbox_user_submit_requests_path(current_user.id) , notice: '却下しました' }
     format.js
     #format.html
    end
  end

  def reject
    #承認取り消し
    @submit_request02.update(status: 8)
    #依頼者自らが取り消す。　タスクは取り消している本人にもどす
    @submit_request02.task.update(status: 8, charge_id: current_user.id)
    
    #自分が依頼しているもの一覧の表示
    @submit_requests = SubmitRequest.where(user_id: current_user.id).order("updated_at DESC")
    
    respond_to do |format|
     format.html { redirect_to user_submit_requests_path(current_user.id) , notice: '取り消しました' }
     format.js
    end
  end

  def inbox
    #依頼されているもの = 担当者が自分である　一覧表示
    #@Submit_Requests = SubmitRequest.where(charge_id: current_user.id).order("updated_at DESC")
    @Submit_Requests = SubmitRequest.where.not(status: 8).where(charge_id: current_user.id).order("updated_at DESC")
    
  end
  
  private
  
  def submit_request_params
    params.require(:submit_request).permit(:task_id, :user_id, :charge_id, :status, :message)
  end
  
   def set_submit_request
    @submit_request = SubmitRequest.find(params[:id])
  end
  
   def set_submit_request02
    @submit_request02 = SubmitRequest.find(params[:submit_request_id])
   end
  
  
end
