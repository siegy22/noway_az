require "test_helper"

class StatisticsTest < ActiveSupport::TestCase
  setup do
    @stats = Statistics.new
  end

  test "current champ" do
    assert_equal champions(:ziggs), @stats.current_champion
  end
end
