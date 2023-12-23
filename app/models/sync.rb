class Sync
  def self.start!(overwrite: false)
    return unless Rails.application.config.api_key

    ActiveRecord::Base.transaction do
      api_client = RiotApiClient.new
      match_ids = api_client.match_ids
      match_ids -= Match.pluck(:riot_id) unless overwrite
      matches = match_ids.map { |match_id| api_client.match(match_id) }

      Match.sync_from_payload!(matches)
    end

    Turbo::StreamsChannel.broadcast_update_to(:progress, target: "progress", locals: { overlay: true }, partial: "home/progress")
  end

  def self.poll!
    loop do
      puts "Starting sync at #{Time.now}"
      self.start!
      puts "Finished sync at #{Time.now}"
      sleep 15
    end
  end
end
