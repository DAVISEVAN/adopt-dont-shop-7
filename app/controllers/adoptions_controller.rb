class AdoptionsController < ApplicationController
    def Show
        @adoption = Adoption.find(params[:id])
    end
end