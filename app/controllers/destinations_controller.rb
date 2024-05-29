class DestinationsController < ApplicationController
  before_action :get_destination, only: :show
  rescue_from ActiveRecord::RecordNotFound, with: :destination_not_found

  def index
    @destinations = Destination.order(:name)
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
    render plain: "404 Destination Not Found", status: 404
  end

end
