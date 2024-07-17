class Admin::SheltersController < ApplicationController
    def index
      @shelters = Shelter.ordered_by_name_desc
      @pending_shelters = Shelter.with_pending_applications
    end

  end
  