class Admin::AdoptionsController < ApplicationController
    def show
      @adoption = Adoption.find(params[:id])
    end
  
    def approve_pet
      adoption_pet = AdoptionPet.find_by(adoption_id: params[:id], pet_id: params[:pet_id])
      adoption_pet.approve
      redirect_to "/admin/adoptions/#{params[:id]}"
    end
  
    def reject_pet
      adoption_pet = AdoptionPet.find_by(adoption_id: params[:id], pet_id: params[:pet_id])
      adoption_pet.reject
      redirect_to "/admin/adoptions/#{params[:id]}"
    end
  end
  