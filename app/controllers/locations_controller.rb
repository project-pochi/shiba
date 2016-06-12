class LocationsController < ApplicationController

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.save
    redirect_to new_location_url
  end

  private
    def location_params
      params.require(:location).permit(:zip_code)
    end
end
