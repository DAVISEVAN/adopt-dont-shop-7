  Rails.application.routes.draw do
    # Adoption routes
  get "/", to: "application#welcome"
  get '/adoptions', to: 'adoptions#index'
  get '/adoptions/new', to: 'adoptions#new'
  post '/adoptions', to: 'adoptions#create'
  get '/adoptions/:id', to: 'adoptions#show'
  get '/adoptions/:id/edit', to: 'adoptions#edit'
  patch '/adoptions/:id', to: 'adoptions#update'
  put '/adoptions/:id', to: 'adoptions#update'
  delete '/adoptions/:id', to: 'adoptions#destroy'

  # AdoptionPet routes
  post '/adoptions/:adoption_id/adoption_pets', to: 'adoption_pets#create', as: 'adoption_adoption_pets'
  delete '/adoptions/:adoption_id/adoption_pets/:id', to: 'adoption_pets#destroy', as: 'adoption_adoption_pet'
  
  # Shelter routes
  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  get "/shelters/:id", to: "shelters#show"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"
  delete "/shelters/:id", to: "shelters#destroy"

  # Pet routes
  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"

  # VeterinaryOffice route
  get "/veterinary_offices", to: "veterinary_offices#index"
  get "/veterinary_offices/new", to: "veterinary_offices#new"
  get "/veterinary_offices/:id", to: "veterinary_offices#show"
  post "/veterinary_offices", to: "veterinary_offices#create"
  get "/veterinary_offices/:id/edit", to: "veterinary_offices#edit"
  patch "/veterinary_offices/:id", to: "veterinary_offices#update"
  delete "/veterinary_offices/:id", to: "veterinary_offices#destroy"

  # Veterinarian routes
  get "/veterinarians", to: "veterinarians#index"
  get "/veterinarians/:id", to: "veterinarians#show"
  get "/veterinarians/:id/edit", to: "veterinarians#edit"
  patch "/veterinarians/:id", to: "veterinarians#update"
  delete "/veterinarians/:id", to: "veterinarians#destroy"

  # ShelterPet routes
  get "/shelters/:shelter_id/pets", to: "shelters#pets"
  get "/shelters/:shelter_id/pets/new", to: "pets#new"
  post "/shelters/:shelter_id/pets", to: "pets#create"

  # VeterinaryOfficeVeterinarian routes
  get "/veterinary_offices/:veterinary_office_id/veterinarians", to: "veterinary_offices#veterinarians"
  get "/veterinary_offices/:veterinary_office_id/veterinarians/new", to: "veterinarians#new"
  post "/veterinary_offices/:veterinary_office_id/veterinarians", to: "veterinarians#create"
end
