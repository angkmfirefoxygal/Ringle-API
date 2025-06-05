Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :students, only: [:create]
      resources :tutors, only: [:create] do
        resources :availabilities, only: [:create]
      end

      resources :availabilities, only: [:destroy]

      get '/available_slots', to: 'slots#index'
      get '/available_tutors', to: 'slots#available_tutors'

      resources :enrollments, only: [:create]
      get '/students/:id/enrollments', to: 'enrollments#index'
    end
  end
end
