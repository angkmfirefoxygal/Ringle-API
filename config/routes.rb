Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Primary API routes
      # POST   /api/v1/availabilities
      # DELETE /api/v1/availabilities/:id
      # POST   /api/v1/enrollments
      # GET    /api/v1/students/:id/enrollments
      # GET    /api/v1/available_slots
      # GET    /api/v1/available_tutors

      resources :availabilities, only: %i[create destroy]
      resources :enrollments, only: %i[create]

      get "/students/:id/enrollments", to: "enrollments#index"
      get "/available_slots",          to: "slots#index"
      get "/available_tutors",         to: "slots#available_tutors"
    end
  end
end
