class DestinationsController < ApplicationController
  before_action :get_destination, only: :show

  def index
    @destinations = Destination.order(:name)
  end

  def random
    @destination = Destination.select_random
    redirect_to destinaton_path(@destination)
  end

  private

  def get_destination
    @destination = Destination.find(params[:id])
  end
end
