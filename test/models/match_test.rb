require "test_helper"

class MatchTest < ActiveSupport::TestCase
  test "sync from payload" do
    assert_difference -> { Match.count }, +3 do
      Match.sync_from_payload!(
        [
          create_payload("EUW_100", 32.minutes.to_i, champions(:vladimir), false, 1, 3, 8, 230, 12.03, 0.45),
          create_payload("EUW_101", 35.minutes.to_i, champions(:vladimir), true, 5, 1, 6, 300, 3.24, 4.47),
          create_payload("EUW_102", 40.minutes.to_i, champions(:veigar), true, 14, 3, 20, 350, 10, 12.42)
        ]
      )
    end

    control_match = Match.find_by(riot_id: "EUW_100")
    assert_equal 32.minutes.to_i, control_match.duration
    assert_equal champions(:vladimir), control_match.champion
    assert_equal false, control_match.win
    assert_equal 3.0, control_match.kda
    assert_equal 7.5775, control_match.cs_per_minute
  end

  test "sync with perfect KDA" do
    Match.sync_from_payload!(
      [
        create_payload("EUW_100", 30.minutes.to_i, champions(:gragas), true, 12, 0, 13, 240, 10.03, 2.45),
      ]
    )
    match = Match.find_by(riot_id: "EUW_100")
    assert_equal Float::INFINITY, match.kda
  end

  test "sync remake" do
    Match.sync_from_payload!(
      [
        create_payload("EUW_100", 3.minutes.to_i, champions(:gragas), true, 12, 0, 13, 240, 10.03, 2.45),
      ]
    )
    assert_raises ActiveRecord::RecordNotFound do
      Match.find_by!(riot_id: "EUW_100")
    end
  end

  test "sync remake doesn't cause duplicates" do
    assert_difference(-> { Match.unscoped.count }, +1) do
      2.times do
        Match.sync_from_payload!(
          [
            create_payload("EUW_100", 3.minutes.to_i, champions(:gragas), true, 12, 0, 13, 240, 10.03, 2.45),
          ]
        )
      end
    end
  end

  private
  def create_payload(
        id,
        duration,
        champion,
        win,
        kills,
        deaths,
        assists,
        minion_kills,
        ally_jungle_monster_kills,
        enemy_jungle_monster_kills
      )
    {
      "metadata" => {
        "matchId" => id
      },
      "info" => {
        "gameDuration" => duration,
        "participants" => [
          {
            "puuid" => Rails.application.config.noway_puuid,
            "championId" => champion.id,
            "win" => win,
            "kills" => kills,
            "deaths" => deaths,
            "assists" => assists,
            "totalMinionsKilled" => minion_kills,
            "challenges" => {
              "alliedJungleMonsterKills" => ally_jungle_monster_kills,
              "enemyJungleMonsterKills" => enemy_jungle_monster_kills
            }
          }
        ]
      }
    }
  end
end
