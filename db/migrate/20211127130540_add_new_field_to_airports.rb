class AddNewFieldToAirports < ActiveRecord::Migration[6.1]
  def change
    add_column :airports, :name_en, :string
    add_column :airports, :description_en, :text
  end
end
