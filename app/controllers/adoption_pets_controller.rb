class AdoptionPetsController < ApplicationController
    def create
      @adoption = Adoption.find(params[:adoption_id])
      @pet = Pet.find(params[:pet_id])
      AdoptionPet.create(adoption: @adoption, pet: @pet)
      redirect_to "/adoptions/#{@adoption.id}"
    end
  end
  