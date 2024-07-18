class AdoptionPet < ApplicationRecord
  belongs_to :adoption
  belongs_to :pet

  def approve
    update(approved: true, rejected: false)
  end

  def reject
    update(approved: false, rejected: true)
  end

  def reset_status
    update(approved: nil, rejected: nil)
  end
end
