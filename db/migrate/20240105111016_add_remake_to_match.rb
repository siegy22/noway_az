class AddRemakeToMatch < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :remake, :boolean, default: false
  end
end
