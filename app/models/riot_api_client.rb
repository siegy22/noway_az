class RiotApiClient
  include HTTParty
  base_uri 'https://europe.api.riotgames.com/lol'

  START_TIME = Time.zone.parse("Mon, Dec 15, 2023 00:00 AM").to_i

  def initialize
    @options = { query: { api_key: Rails.application.config.api_key } }
  end

  def match_ids(start_time = START_TIME)
    start = 0
    responses = []
    loop do
      response = self.class.get(
        "/match/v5/matches/by-puuid/#{puuid}/ids",
        @options.deep_merge(
          query: {
            count: 100,
            queue: 420,
            startTime: start_time,
            start: start
          }
        )
      )

      break if response.count.zero?

      responses.prepend(response)
      start += response.count
    end

    responses.flatten
  end

  def match(id)
    self.class.get("/match/v5/matches/#{id}", @options)
  end

  private
  def puuid
    Rails.application.config.noway_puuid
  end
end
