require "test_helper"

class StatisticsTest < ActiveSupport::TestCase
  setup do
    @stats = Statistics.new
  end

  test "current champ" do
    assert_equal champions(:alistar), @stats.current_champion
  end

  test "previous and next champs" do
    assert_equal [champions(:ahri), champions(:akali), champions(:akshan)], @stats.previous_champions.limit(3).reverse
    assert_equal [champions(:amumu), champions(:anivia), champions(:annie)], @stats.next_champions.limit(3)
  end
end
