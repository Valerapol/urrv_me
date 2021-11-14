class AddSlugToAirports < ActiveRecord::Migration[6.1]
  def change
    add_column :airports, :slug, :string
    add_index :airports, :slug, unique: true
  end
end
