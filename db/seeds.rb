# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


response = HTTParty.get("http://ddragon.leagueoflegends.com/cdn/12.4.1/data/en_US/champion.json")
response["data"].each do |_, data|
  Champion.find_or_create_by!(id: data["key"], name: data["name"], riot_id: data["id"])
end
