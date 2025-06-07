# app/controllers/api/v1/availabilities_controller.rb
class Api::V1::AvailabilitiesController < ApplicationController
    def create
      tutor = Tutor.find(params[:tutor_id])
      availability = tutor.availabilities.create!(start_time: params[:start_time])
      render json: availability, status: :created
    end

    def destroy
      availability = Availability.find(params[:id])
      availability.destroy
      head :no_content
    end
end
