class DestinationsController < ApplicationController
  def index
    @destinations = Destination.order(:name)
  end

  def show
    @destination = Destination.select_random
  end
end
