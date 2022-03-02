class Champion < ApplicationRecord
  has_many :matches

  def finished?
    matches.any?(&:win)
  end

  def started?
    matches.count.positive?
  end

  def statistics_id
    "champ-stat-#{riot_id.downcase}"
  end
end
