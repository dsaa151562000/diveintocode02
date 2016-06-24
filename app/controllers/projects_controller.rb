class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    

  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @customers = Customer.all
    @memberships = Membership.all
    #binding pry
  end

  # GET /projects/1/edit
  def edit
    @customers = Customer.all
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: '新規プロジェクトを登録しました。' }
        format.json { render :show, status: :created, location: @project }
      else
         @customers = Customer.all
        format.html { render :new}
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'プロジェクトを更新しました。' }
        format.json { render :show, status: :ok, location: @project }
      else
         @customers = Customer.all
        format.html { render :edit }
        #format.js { render :index, notice: 'プロジェクトを削除しました。' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: '新規プロジェクトを削除しました。' }
      format.json { head :no_content }
    end
  end


  def  membering
    @users = User.page(params[:page])
    @pj_num = params[:id]
    
    #参加しているか確認する
    @member_list = Membership.where(project_id: params[:id])
    #binding pry

  end
  
  def  member_list
    @project_master =Project.find(params[:id])
    
    #参加しているか確認する
    @member_list = Membership.where(project_id: params[:id])

  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:user_id, :title, :content, :deadline, :customer_id, :done, :status)
    end
    
     # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:user_id, :project_id)
    end
end
