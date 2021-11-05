class RemoveFieldLogoFromAirports < ActiveRecord::Migration[6.1]
  def change
    remove_column :airports, :logo, :string
  end
end
