class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.string :riot_id, unique: true
      t.boolean :win
      t.belongs_to :champion, foreign_key: true
      t.integer :kills
      t.integer :deaths
      t.integer :assists
      t.integer :duration
      t.float :cs_per_minute

      t.timestamps
    end
  end
end
