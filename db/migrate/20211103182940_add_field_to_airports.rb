class AddFieldToAirports < ActiveRecord::Migration[6.1]
  def change
    add_column :airports, :iata, :string
    add_column :airports, :aip, :text
    add_column :airports, :logo, :string
  end
end
