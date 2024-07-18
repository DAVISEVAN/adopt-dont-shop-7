class Admin::AdoptionsController < ApplicationController
    def show
      @adoption = Adoption.find(params[:id])
    end
  
    def approve_pet
      @adoption = Adoption.find(params[:id])
      @adoption.approve_pet(params[:pet_id])
      redirect_to "/admin/adoptions/#{@adoption.id}"
    end
  end
  