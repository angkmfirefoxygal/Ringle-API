# app/controllers/api/v1/enrollments_controller.rb
class Api::V1::EnrollmentsController < ApplicationController
    def create
      enrollment = Enrollment.create!(
        student_id: params[:student_id],
        tutor_id: params[:tutor_id],
        start_time: params[:start_time],
        duration: params[:duration]
      )
      render json: enrollment, status: :created
    end
  
    def index
      student = Student.find(params[:id])
      enrollments = student.enrollments.includes(:tutor)
      render json: enrollments.map { |e| {
        start_time: e.start_time,
        duration: e.duration,
        tutor_name: e.tutor.name
      }}
    end
  end
  