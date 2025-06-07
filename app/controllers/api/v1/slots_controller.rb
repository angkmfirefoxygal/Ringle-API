# app/controllers/api/v1/slots_controller.rb
# Provides queries for available class time slots and tutors.
class Api::V1::SlotsController < ApplicationController
    # GET /api/v1/available_slots
    # Params: start_date (required), end_date (required), duration (required)
    # Returns an array of available start times.
    def index
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      duration = params[:duration].to_i

      start_times = []
      (start_date..end_date).each do |date|
        (0..47).each do |i|  # 30분 단위로 하루 48개
          time = date.to_time + i * 30.minutes
          if duration == 30
            start_times << time if Availability.exists?(start_time: time)
          elsif duration == 60
            next_time = time + 30.minutes
            availabilities = Availability.where(start_time: time)
            if availabilities.any? { |a| a.tutor.availabilities.exists?(start_time: next_time) }
              start_times << time
            end
          end
        end
      end

      render json: start_times.uniq.map { |t| { start_time: t } }
    end

  
    # GET /api/v1/available_tutors
    # Params: start_time (required), duration (required)
    # Returns tutors available at the given time.

    def available_tutors
      start_time = Time.zone.parse(params[:start_time])
      duration = params[:duration].to_i


      tutors = Tutor.joins(:availabilities).where(availabilities: { start_time: start_time })

      if duration == 60
        next_block = start_time + 30.minutes
        tutors = tutors.select do |tutor|
          tutor.availabilities.exists?(start_time: next_block)
        end
      end

      render json: tutors.map { |t| { id: t.id, name: t.name } }
    end
end
