class RemoveFieldSceneryFromAirports < ActiveRecord::Migration[6.1]
  def change
    remove_column :airports, :scenery, :string
  end
end
