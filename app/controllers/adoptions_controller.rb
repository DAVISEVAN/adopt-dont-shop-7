class AdoptionsController < ApplicationController
    def show
        @adoption = Adoption.find(params[:id])
    end
end