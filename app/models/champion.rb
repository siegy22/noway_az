class Champion < ApplicationRecord
  has_many :matches

  def finished?
    matches.any?(&:win)
  end
end
