class DestinationsController < ApplicationController
  before_action :get_destination, only: :show
  rescue_from ActiveRecord::RecordNotFound, with: :destination_not_found

  def index
    @destinations = Destination.includes(:region, :flag_primary, :flag_secondary, :language_primary, :language_secondary).order(:name)
  end

  def random
    @destination = Destination.select_random
    redirect_to destination_path(@destination)
  end

  private

  def get_destination
    @destination = Destination.find(params[:id])
  end

  def destination_not_found
    render :not_found, status: :not_found
  end

end
