# app/controllers/api/v1/availabilities_controller.rb
# Manages creation and deletion of tutor availability time slots.
class Api::V1::AvailabilitiesController < ApplicationController
    # POST /api/v1/availabilities
    # Params: tutor_id (required), start_time (required)
    # Returns the created availability as JSON.
    def create
      tutor = Tutor.find(params[:tutor_id])
      availability = tutor.availabilities.create!(start_time: params[:start_time])
      render json: availability, status: :created
    end

  
    # DELETE /api/v1/availabilities/:id
    # Params: id (required)
    # Returns no content.
  
    def destroy
      availability = Availability.find(params[:id])
      availability.destroy
      head :no_content
    end
end
