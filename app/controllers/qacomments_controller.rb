class QacommentsController < ApplicationController
  before_action :set_qacomment, only: [:show, :edit, :update, :destroy]

  # GET /qacomments
  # GET /qacomments.json
  def index
    @qacomments = Qacomment.all

    @user = current_user
  end

  # GET /qacomments/1
  # GET /qacomments/1.json
  def show

  end

  # GET /qacomments/new
  def new
    @qacomment = Qacomment.new
  end

  # GET /qacomments/1/edit
  def edit
  end

  # POST /qacomments
  # POST /qacomments.json
  def create
    @qacomment = Qacomment.new(qacomment_params)

    respond_to do |format|
      if @qacomment.save
        format.html { redirect_to @qacomment, notice: 'Qacomment was successfully created.' }
        format.json { render :show, status: :created, location: @qacomment }
      else
        format.html { render :new }
        format.json { render json: @qacomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qacomments/1
  # PATCH/PUT /qacomments/1.json
  def update
    respond_to do |format|
      if @qacomment.update(qacomment_params)
        format.html { redirect_to @qacomment, notice: 'Qacomment was successfully updated.' }
        format.json { render :show, status: :ok, location: @qacomment }
      else
        format.html { render :edit }
        format.json { render json: @qacomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qacomments/1
  # DELETE /qacomments/1.json
  def destroy
    @qacomment.destroy
    respond_to do |format|
      format.html { redirect_to qacomments_url, notice: 'Qacomment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qacomment
      @qacomment = Qacomment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qacomment_params
      params.require(:qacomment).permit(:qa_id, :user_id, :content)
    end
end
