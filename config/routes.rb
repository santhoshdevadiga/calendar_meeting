Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :meetings
      resources :meeting_rooms
      resources :employees do
        get 'meetings', on: :member
      end
    end
  end
end
