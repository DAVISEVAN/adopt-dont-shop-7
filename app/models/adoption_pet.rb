class AdoptionPet < ApplicationRecord
  belongs_to :adoption
  belongs_to :pet

  def approve
    update(approved: true, rejected: false)
  end

  def reject
    update(approved: false, rejected: true)
  end
end
