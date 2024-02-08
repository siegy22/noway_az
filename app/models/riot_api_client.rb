class RiotApiClient
  include HTTParty
  base_uri 'https://europe.api.riotgames.com/lol'

  START_TIME = Statistics::START_DATE.noon

  def initialize
    @options = { query: { api_key: Rails.application.config.api_key } }
  end

  def match_ids(queue: 420, start_time: START_TIME)
    start = 0
    responses = []
    loop do
      response = self.class.get(
        "/match/v5/matches/by-puuid/#{puuid}/ids",
        @options.deep_merge(
          query: {
            count: 100,
            queue: queue,
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
