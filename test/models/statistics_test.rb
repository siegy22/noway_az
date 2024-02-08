require "test_helper"

class StatisticsTest < ActiveSupport::TestCase
  setup do
    @stats = Statistics.new
  end

  test "current champ" do
    assert_equal champions(:ziggs), @stats.current_champion
  end

  test "previous and next champs" do
    assert_equal [champions(:zyra), champions(:zoe), champions(:zilean)], @stats.previous_champions.limit(3).reverse
    assert_equal [champions(:zeri), champions(:zed), champions(:zac)], @stats.next_champions.limit(3)
  end
end
