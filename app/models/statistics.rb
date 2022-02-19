class Statistics
  def total_games
    Match.count
  end

  def winrate
    (Match.where(win: true).count / Match.count.to_f * 100).round
  end

  START_DATE = Date.parse("2022-02-14")
  def duration
    (Date.today - START_DATE).to_i.days
  end

  def finished_champions
    champions.having("COUNT(*) FILTER (WHERE win = TRUE) > 0")
  end

  def total_champions
    Champion
  end

  def current_champion
    Champion.where.not(id: finished_champions.map(&:champion_id)).order(name: :desc).first
  end

  def champions
    Match.select(
      <<-SQL
champion_id,
COUNT(*) AS matches_played,
COUNT(*) FILTER (WHERE win = TRUE) as matches_won,
SUM(kills) as kills,
SUM(deaths) as deaths,
SUM(assists) as assists,
AVG(cs_per_minute) AS cs_per_minute
SQL
    ).group(:champion_id).includes(:champion).order(matches_played: :desc)
  end
end
