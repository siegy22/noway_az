require "application_system_test_case"

class AppTest < ApplicationSystemTestCase
  YORICK = ["Yorick", "1", "0%", "5,00", "9,3"]
  ZILEAN = ["Zilean", "1", "100%", "Perfekt", "1,2"]
  ZOE = ["Zoe", "2", "50%", "3,56", "8,4"]
  ZYRA = ["Zyra", "1", "100%", "6,00", "2,1"]

  test "test" do
    visit '/'

    assert_equal "Ziggs", find("#current-champion")["title"]
    assert_equal "3 / 159", find("#progress").text
    assert_equal "5", find("#games").text
    assert_equal "60%", find("#winrate").text

    assert_equal [
      ZOE,
      YORICK,
      ZILEAN,
      ZYRA
    ], champ_stats

    find("#sort-by-champion").click()
    assert_equal [
      ZYRA,
      ZOE,
      ZILEAN,
      YORICK
    ], champ_stats
    find("#sort-by-champion").click()
    assert_equal [
      YORICK,
      ZILEAN,
      ZOE,
      ZYRA
    ], champ_stats


    find("#sort-by-winrate").click()
    assert_equal [
      ZILEAN,
      ZYRA,
      ZOE,
      YORICK
    ], champ_stats
  end

  private
  def champ_stats
    all("#champ-stats tr").map do |row|
      row.all("td:not(:first-child)").map(&:text).map(&:strip)
    end
  end
end
