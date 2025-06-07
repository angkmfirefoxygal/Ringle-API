# app/controllers/api/v1/enrollments_controller.rb
# Handles student enrollments for tutoring sessions.
class Api::V1::EnrollmentsController < ApplicationController
    # POST /api/v1/enrollments
    # Params: student_id (required), tutor_id (required), start_time (required), duration (required)
    # Returns the created enrollment as JSON.
    def create
      enrollment = Enrollment.create!(
        student_id: params[:student_id],
        tutor_id: params[:tutor_id],
        start_time: params[:start_time],
        duration: params[:duration]
      )
      render json: enrollment, status: :created
    end


    # GET /api/v1/students/:id/enrollments
    # Params: id (required)
    # Returns an array of enrollments with tutor names.

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
