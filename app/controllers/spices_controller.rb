class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  wrap_parameters format: []

  def index
    render json: Spice.all, status: :ok
  end

  def create
    spice = Spice.create(spices_params)
    render json: spice, status: :created
  end

  def update
    spice = find_by_id
    spice.update(spices_params)
    render json: spice
  end

  def destroy
    spice = find_by_id
    spice.destroy
  end

  private
  def spices_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def find_by_id
    Spice.find(params[:id])
  end

  def not_found_response
    render json: { error: "Spice not found" }, status: :not_found
  end
end
