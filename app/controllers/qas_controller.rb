class QasController < ApplicationController
  before_action :set_qa, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /qas
  # GET /qas.json
  def index
    @qas = Qa.all
    @user = current_user
    @category = ['プログラミングの相談', 'webアプリ開発', 'ネイティブアプリ開発', 'サーバー・インフラ構築の相談', 'その他（IT・プログラミング）']
    @language = ['ruby', 'php', 'java', 'c', 'shell script']
  end

  # GET /qas/1
  # GET /qas/1.json
  def show
    @qacommnent = @qa.qacomments.build
    @qacommnents = @qa.qacomments
    @user = current_user
    
    #!@qacommnents=@qacommnents.content.gsub(/\r\n|\r|\n/, "<br />").html_safe
    
    @category = ['プログラミングの相談', 'webアプリ開発', 'ネイティブアプリ開発', 'サーバー・インフラ構築の相談', 'その他（IT・プログラミング）']
    @language = ['ruby', 'php', 'java', 'c', 'shell script']
    
    
  end

  # GET /qas/new
  def new
    @qa = Qa.new
  end

  # GET /qas/1/edit
  def edit
  end

  # POST /qas
  # POST /qas.json
  def create
    #@qa = Qa.new(qa_params)
    #@blog= current_user.blogs.build(blog_params)
    @qa = current_user.qas.build(qa_params)
    
    respond_to do |format|
      if @qa.save
        format.html { redirect_to @qa, notice: 'ご質問を受付ました' }
        format.json { render :show, status: :created, location: @qa }
      else
        format.html { render :new }
        format.json { render json: @qa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qas/1
  # PATCH/PUT /qas/1.json
  def update
    respond_to do |format|
      if @qa.update(qa_params)
        format.html { redirect_to @qa, notice: 'Qa was successfully updated.' }
        format.json { render :show, status: :ok, location: @qa }
      else
        format.html { render :edit }
        format.json { render json: @qa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qas/1
  # DELETE /qas/1.json
  def destroy
    @qa.destroy
    respond_to do |format|
      format.html { redirect_to qas_url, notice: 'Qa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qa
      @qa = Qa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qa_params
      params.require(:qa).permit(:title, :content, :category_id, :language_id)
    end
    
    def program_param
     @category = ['プログラミングの相談', 'webアプリ開発', 'ネイティブアプリ開発', 'サーバー・インフラ構築の相談', 'その他（IT・プログラミング）']
   end
end