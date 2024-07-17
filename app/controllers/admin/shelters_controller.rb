class Admin::SheltersController < ApplicationController
    def index
      @shelters = Shelter.ordered_by_name_desc
    end
  end
  