class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update]
  before_action :authenticate_user!
  respond_to :html, :js

  # GET /memberships
  # GET /memberships.json
  def index
    #@memberships = Membership.all
    @memberships = Membership.page(params[:page])
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show

  end

  # GET /memberships/new
  def new
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)
    @user = User.find(params[:membership][:user_id])
    #binding pry
    @pjnum =  params[:membership][:project_id]
    
     #binding pry
    
    #@h2 = Hash.new
    #@h2= { first: 1, second: 2}
    
   #binding pry
    respond_to do |format|
      if @membership.save
        #format.html { redirect_to membering_project_path(@membership.project_id) , notice: 'メンバーに追加しました' }
        format.js  #{ redirect_to membering_project_path(@membership.project_id)  }
       # format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  # def update
  #   respond_to do |format|
  #     if @membership.update(membership_params)
  #       format.html { redirect_to @membership, notice: '更新しました' }
  #       format.json { render :show, status: :ok, location: @membership }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @membership.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
     @pj_num = params[:membership]
     #binding.pry
    @membership= Membership.find_by(user_id: @pj_num[:user_id])
    @user = User.find(params[:membership][:user_id])
    @membership.destroy
    respond_to do |format|
      #format.html { redirect_to  membering_project_path(@membership.project_id) , notice: 'メンバーから削除しました' }
      #format.json { head :no_content }
      format.js
    end
  end
  
  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:user_id, :project_id)
    end
end
