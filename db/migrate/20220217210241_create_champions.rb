class CreateChampions < ActiveRecord::Migration[7.0]
  def change
    create_table :champions do |t|
      t.string :riot_id
      t.string :name
      
      t.timestamps
    end
  end
end
