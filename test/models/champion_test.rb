require "test_helper"

class ChampionTest < ActiveSupport::TestCase
  test "finished" do
    assert champions(:zyra).finished?
    assert champions(:zoe).finished?
    assert_not champions(:yone).finished?
    assert_not champions(:cho_gath).finished?
  end
end
