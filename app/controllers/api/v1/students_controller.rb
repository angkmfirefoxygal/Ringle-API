# app/controllers/api/v1/students_controller.rb
class Api::V1::StudentsController < ApplicationController
    def create
      student = Student.create!(name: params[:name])
      render json: student, status: :created
    end
  end
  