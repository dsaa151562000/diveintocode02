class ProjecttasksController < ApplicationController
  before_action :set_projecttask, only: [:show, :edit, :update, :destroy]

  # GET /projecttasks
  # GET /projecttasks.json
  def index
    @projecttasks = Projecttask.all
    @project = Project.find(params[:project_id])
  end

  # GET /projecttasks/1
  # GET /projecttasks/1.json
  def show
  end

  # GET /projecttasks/new
  def new
    @projecttask = Projecttask.new
    #Parameters: {"project_id"=>"6"}
    @pj_num = params[:project_id]
    #binding pry
  end

  # GET /projecttasks/1/edit
  def edit
  end

  # POST /projecttasks
  # POST /projecttasks.json
  def create
   # @projecttask = Projecttask.new(projecttask_params)
    @projecttask= current_user.projecttasks.build(projecttask_params)
    #binding pry
    respond_to do |format|
      if @projecttask.save
        
        format.html { redirect_to @projecttask, notice: 'Projecttask was successfully created.' }
        format.json { render :show, status: :created, location: @projecttask }
      else
        format.html { render :new }
        format.json { render json: @projecttask.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projecttasks/1
  # PATCH/PUT /projecttasks/1.json
  def update
    respond_to do |format|
      if @projecttask.update(projecttask_params)
        format.html { redirect_to @projecttask, notice: 'Projecttask was successfully updated.' }
        format.json { render :show, status: :ok, location: @projecttask }
      else
        format.html { render :edit }
        format.json { render json: @projecttask.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projecttasks/1
  # DELETE /projecttasks/1.json
  def destroy
    @projecttask.destroy
    respond_to do |format|
      format.html { redirect_to projecttasks_url, notice: 'Projecttask was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projecttask
      @projecttask = Projecttask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def projecttask_params
      params.require(:projecttask).permit(:user_id, :project_id, :projecttask_title, :projecttask_content, :projecttask_deadline, :projecttask_charge_id, :projecttask_done, :projecttask_status)
    end
end
