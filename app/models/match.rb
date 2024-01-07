class Match < ApplicationRecord
  default_scope { where.not(remake: true) }
  belongs_to :champion

  def self.sync_from_payload!(matches)
    matches.each do |match|
      player_data = match["info"]["participants"].find do |participant|
        participant["puuid"] == Rails.application.config.noway_puuid
      end

      instance = unscoped.find_or_create_by!(riot_id: match["metadata"]["matchId"], champion_id: player_data["championId"])
      instance.update!(
        remake: match["info"]["gameDuration"] < 4.minutes.to_i,
        duration: match["info"]["gameDuration"],
        win: player_data["win"],
        kills: player_data["kills"],
        deaths: player_data["deaths"],
        assists: player_data["assists"],
        cs_per_minute: (
          (
            player_data["totalMinionsKilled"].to_f +
            player_data["challenges"]["alliedJungleMonsterKills"].to_f +
            player_data["challenges"]["enemyJungleMonsterKills"].to_f
          ) / match["info"]["gameDuration"].seconds.in_minutes
        )
      )
    end
  end

  def kda
    (kills + assists) / deaths.to_f
  end

  def perfect_kda?
    kda == Float::INFINITY
  end
end
