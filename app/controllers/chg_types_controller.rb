class ChgTypesController < ApplicationController
  before_action :set_chg_type, only: [:show, :edit, :update, :destroy]

  # GET /chg_types
  # GET /chg_types.json
  def index
    respond_to do |format|
      format.html do
        @chg_types = ChgType.all
      end
      format.csv do
        @chg_types = ChgType.all
        send_data render_to_string, type: 'text/csv; charset=shift_jis'
      end
    end


  end

  # GET /chg_types/1
  # GET /chg_types/1.json
  def show
  end

  # GET /chg_types/new
  def new
    @chg_type = ChgType.new
  end

  # GET /chg_types/1/edit
  def edit
  end

  # POST /chg_types
  # POST /chg_types.json
  def create
    @chg_type = ChgType.new(chg_type_params)

    respond_to do |format|
      if @chg_type.save
        format.html { redirect_to @chg_type, notice: t('message.template.scaffold.create', model: t('activerecord.models.chg_type')) }
        format.json { render :show, status: :created, location: @chg_type }
      else
        format.html { render :new }
        format.json { render json: @chg_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chg_types/1
  # PATCH/PUT /chg_types/1.json
  def update
    respond_to do |format|
      if @chg_type.update(chg_type_params)
        format.html { redirect_to @chg_type, notice: t('message.template.scaffold.update', model: t('activerecord.models.chg_type')) }
        format.json { render :show, status: :ok, location: @chg_type }
      else
        format.html { render :edit }
        format.json { render json: @chg_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chg_types/1
  # DELETE /chg_types/1.json
  def destroy
    @chg_type.destroy
    respond_to do |format|
      format.html { redirect_to chg_types_url, notice: t('message.template.scaffold.destroy', model: t('activerecord.models.chg_type')) }
      format.json { head :no_content }
    end
  end

  def import
    ChgType.import(params[:file])
    redirect_to chg_types_url, notice: t('message.template.csv_upload.upload_success', model: t('activerecord.models.chg_type'))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chg_type
      @chg_type = ChgType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chg_type_params
      params.require(:chg_type).permit(:name)
    end
end
