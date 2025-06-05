# app/controllers/api/v1/tutors_controller.rb
class Api::V1::TutorsController < ApplicationController
    def create
      tutor = Tutor.create!(name: params[:name])
      render json: tutor, status: :created
    end
  end
  