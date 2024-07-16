class AdoptionsController < ApplicationController
    def show
        @adoption = Adoption.find(params[:id])
        if params[:search].present?
            @pets = Pet.where("name LIKE ?", "%#{params[:search]}%")
        else
            @pets = []
        end
    end

    def new
        @adoption = Adoption.new
    end

    def create
        @adoption = Adoption.new(adoption_params)
        @adoption.status = 'In Progress'
        if @adoption.save
            redirect_to action: 'show', id: @adoption.id
        else
            flash[:alert] = 'You must fill in all fields.'
        render action: 'new'
        end
    end

    def update
        @adoption = Adoption.find(params[:id])
        if params[:commit] == "Submit Application"
            @adoption.update(status: 'Pending', description: params[:adoption][:description])
        else
            @adoption.update(adoption_params)
        end
        redirect_to "/adoptions/#{params[:id]}"
    end

    private

    def adoption_params
        params.require(:adoption).permit(:name, :street_address, :city, :state, :zip_code, :description)
    end
end