class AddClassaptToAirports < ActiveRecord::Migration[6.1]
  def change
    add_column :airports, :class_apt, :string
  end
end
