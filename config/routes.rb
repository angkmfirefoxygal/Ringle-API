Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutors, only: [] do
        resources :availabilities, only: [:create, :destroy]
      end

      get '/available_slots', to: 'slots#index'
      get '/available_tutors', to: 'slots#available_tutors'

      resources :enrollments, only: [:create]
      get '/students/:id/enrollments', to: 'enrollments#index'
    end
  end
end