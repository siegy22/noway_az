class HomeController < ApplicationController
  def index
    @statistics = Statistics.new
    @champions = Champion.order(name: :desc).includes(:matches)
  end
end
