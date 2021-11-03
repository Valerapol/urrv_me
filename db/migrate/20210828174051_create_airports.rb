class CreateAirports < ActiveRecord::Migration[6.1]
  def change
    create_table :airports do |t|
      t.string :icao
      t.string :name
      t.text :description
      t.string :fir
      t.string :coordinates
      t.string :scenery

      t.timestamps
    end
  end
end
