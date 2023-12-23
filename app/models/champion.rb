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

  def image_url
    "https://ddragon.leagueoflegends.com/cdn/13.24.1/img/champion/#{riot_id}.png"
  end
end
