module ApplicationHelper
  def color_for_matches_played(matches_played)
    case matches_played
    when 1
      'dark:bg-green-400 bg-green-200 hover:bg-green-300'
    when 2
      'dark:bg-yellow-400 bg-yellow-200 hover:bg-yellow-300'
    when 3..4
      'dark:bg-orange-400 bg-orange-200 hover:bg-orange-300'
    else
      'dark:bg-red-500 bg-red-200 hover:bg-red-300'
    end
  end

  def percentage_done(statistics, correction: 0)
    statistics.finished_champions.length / (statistics.total_champions.count.to_f + correction) * 100
  end
end
