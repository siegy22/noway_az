require "test_helper"

class ChampionTest < ActiveSupport::TestCase
  test "finished" do
    assert champions(:ahri).finished?
    assert champions(:akali).finished?
    assert_not champions(:braum).finished?
    assert_not champions(:cho_gath).finished?
  end
end
