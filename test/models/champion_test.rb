require "test_helper"

class ChampionTest < ActiveSupport::TestCase
  test "finished" do
    assert champions(:zyra).finished?
    assert champions(:zoe).finished?
    assert_not champions(:yorick).finished?
    assert_not champions(:vladimir).finished?
  end
end
