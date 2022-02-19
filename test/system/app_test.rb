require "application_system_test_case"

class AppTest < ApplicationSystemTestCase
  test "test" do
    visit '/'

    assert_equal "Ziggs", find("#current-champion")["title"]
    assert_equal "3 / 159", find("#progress").text
    assert_equal "5", find("#games").text
    assert_equal "60%", find("#winrate").text

    assert_equal [
      ["Zoe", "2", "50%", "3.56", "8.4"],
      ["Yorick", "1", "0%", "5.0", "9.3"],
      ["Zilean", "1", "100%", "Perfekt", "1.2"],
      ["Zyra", "1", "100%", "6.0", "2.1"]
    ], champ_stats
  end

  private
  def champ_stats
    all("#champ-stats tr").map do |row|
      row.all("td:not(:first-child)").map(&:text).map(&:strip)
    end
  end
end
