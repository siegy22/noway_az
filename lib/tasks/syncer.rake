namespace :syncer do
  desc "Sync noway matches to database"
  task start: [:environment] do
    Sync.poll!
  end
end
