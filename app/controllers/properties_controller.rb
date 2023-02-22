class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]

  def index
    @properties = Property.all
  end

  def show
  end

  def new
    @property = Property.new
    @property.stations.build
    # accept_nested_attributes_forで紐付けたstationsのインスタンスをビルド

  end

  def edit
    @property.stations.build
  end

  def create
    @property = Property.new(property_params) 
    if params[:back]
      render :new
    else
      if @property.save
        redirect_to properties_path, notice: "Property was successfully created." 
      else
        render :new
      end
    end
  end
  
  def update
      if @property.update(property_params)
        redirect_to @property, notice: "Property was successfully updated." 
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  
  def confirm
    @property = Property.new(property_params)
    render :new if @property.invalid?
    # invalid? はエラーが出た場合にtrueを返す。よってエラーが合ったらnewを表示させるという意味
  end



  private
    def set_property
      @property = Property.find(params[:id])
    end

    def property_params
      params.require(:property).permit(:name, :rent, :adress, :age, :note, 
      stations_attributes: [:line_name, :station_name, :time, :_destroy, :id])
    end
end
