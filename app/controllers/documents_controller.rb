class DocumentsController < ApplicationController
  skip_before_action :authenticate_user!, :only => :index
  before_action :set_document, only: %i[ edit update destroy ]

  def index
    @documents = Document.all
    if params[:set_locale]
      redirect_to documents_url(locale: params[:set_locale])
    end
  end

  def new
    if params[:set_locale]
      redirect_to new_document_url(locale: params[:set_locale])
    end
    @document = Document.new
    authorize @document
  end

  def edit
    if params[:set_locale]
      redirect_to edit_document_url(locale: params[:set_locale])
    end
    authorize @document
  end

  def create
    @document = Document.new(document_params)
    authorize @document

    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_path, notice: "Document was successfully created." }
        format.json { render :index, status: :created, location: @documents }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @document
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to documents_path, notice: "Document was successfully updated." }
        format.json { render :index, status: :ok, location: @documents }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @document
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:title, :aplication, :tipe)
    end
end
