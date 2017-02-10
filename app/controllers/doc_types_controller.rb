class DocTypesController < ApplicationController
  before_action :set_doc_type, only: [:show, :edit, :update, :destroy]

  # GET /doc_types
  # GET /doc_types.json
  def index
     respond_to do |format|
      format.html do
        @doc_types = DocType.all
      end
      format.csv do
        @doc_types = DocType.all
        send_data render_to_string, type: 'text/csv; charset=shift_jis'
      end
    end
  end

  # GET /doc_types/1
  # GET /doc_types/1.json
  def show
  end

  # GET /doc_types/new
  def new
    @doc_type = DocType.new
  end

  # GET /doc_types/1/edit
  def edit
  end

  # POST /doc_types
  # POST /doc_types.json
  def create
    @doc_type = DocType.new(doc_type_params)

    respond_to do |format|
      if @doc_type.save
        format.html { redirect_to @doc_type, notice: t('message.template.scaffold.create', model: t('activerecord.models.doc_type')) }
        format.json { render :show, status: :created, location: @doc_type }
      else
        format.html { render :new }
        format.json { render json: @doc_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doc_types/1
  # PATCH/PUT /doc_types/1.json
  def update
    respond_to do |format|
      if @doc_type.update(doc_type_params)
        format.html { redirect_to @doc_type, notice: t('message.template.scaffold.update', model: t('activerecord.models.doc_type')) }
        format.json { render :show, status: :ok, location: @doc_type }
      else
        format.html { render :edit }
        format.json { render json: @doc_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doc_types/1
  # DELETE /doc_types/1.json
  def destroy
    @doc_type.destroy
    respond_to do |format|
      format.html { redirect_to doc_types_url, notice: t('message.template.scaffold.destroy', model: t('activerecord.models.doc_type')) }
      format.json { head :no_content }
    end
  end

  def import
    DocType.import(params[:file])
    redirect_to doc_types_url, notice: t('message.template.csv_upload.upload_success', model: t('activerecord.models.doc_type'))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doc_type
      @doc_type = DocType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doc_type_params
      params.require(:doc_type).permit(:name)
    end
end
